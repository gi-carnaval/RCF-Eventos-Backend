import { FastifyInstance } from "fastify"
import { prisma } from "../lib/prisma"
import { z } from "zod"
import path from "path"
import ejs from "ejs"
import fs from "fs"
import puppeteer from "puppeteer"

export async function reportRoutes(fastify: FastifyInstance) {

  fastify.get('/eventReport/pdf/:id', async (request, response) =>{
    const getEventParams = z.object({
      id: z.string(),
    })

    const { id } = getEventParams.parse(request.params)
    const browser = await puppeteer.launch({headless: "new"})
    const page = await browser.newPage()

    await page.goto(`${process.env.BASE_URL}/eventReport/${id}`, {
      waitUntil: 'networkidle0'
    })

    await page.pdf({
      path: `./src/report/${id}.pdf`,
      tagged: true,
      printBackground: true,
      format: 'A4',
      margin: {
        top: '20px',
        bottom: '40px',
        left: '20px',
        right: '20px'
      }
    })

    await browser.close()
    const filePath = path.join(__dirname, "../",'/report/', `${id}.pdf`)
    const fileContent = fs.readFileSync(filePath);

    // response.header('Content-Type', 'application/pdf');
    // response.header('Content-Disposition', `attachment; filename="${id}.pdf"`);

    response.send(fileContent);
    return fileContent
    // fs.unlink(path.join(__dirname, "../",'/report/', `${id}.pdf`), (err => { 
    //   if (err) console.log(err); 
    //   else { 
    //     console.log("\nDeleted file: example_file.txt"); 
    //   } 
    // })); 
  })
  
  fastify.get('/eventReport/:id', async (request, response) =>{
    const getEventParams = z.object({
      id: z.string(),
    })
    const { id } = getEventParams.parse(request.params)
    
    const event = await prisma.event.findUnique({
      where: {
        id: id
      },
      select: {
        id: true,
        hirer: true,
        totalValue: true,
        eventType: true,
        appointment: true,
        photographicRegister: true,
        album: true,
        photoShoot: true,
        makingOf: true,
        photoPanel: true,
        discount: true,
        installments: {
          orderBy: {
            installmentNumber: 'asc'
          }
        }
      }
    })


    ejs.renderFile(
      path.join(__dirname, "../", '/reportsTemplate/', 'print.ejs'),
      {event},
      (err, html) => {
        if(err) {
          return response.send(err)
        }
          return response.header('Content-Type', 'text/html').send(html) 
      }
    )
  })

}