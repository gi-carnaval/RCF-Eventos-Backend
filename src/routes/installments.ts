import { FastifyInstance } from "fastify"
import { z } from "zod"
import { prisma } from "../lib/prisma"
import dayjs from "dayjs"
import { getAllInstallments, getFirstInstallmentIdAndQuantityOfInstalls } from "../lib/functions"
import { CreateInstallmentProps } from "../types/installments"
require('dayjs/locale/pt-br')

export async function installmentsRoutes(fastify: FastifyInstance) {
  fastify.delete('/installment/:installmentId', async (request) => {
    const getInstallmentParams = z.object({
      installmentId: z.string()
    })

    const { installmentId } = getInstallmentParams.parse(request.params)

    await prisma.installments.delete({
      where: {
        id: installmentId
      }
    })
  })

  fastify.post('/installment', async (request, response) => {

    const createInstallmentsBody = z.object({
      downPayment: z.number(),
      installmentQuantity: z.number(),
      startDate: z.string(),
      installmentValue: z.number(),
      eventId: z.string()
    })

    const { downPayment, installmentQuantity, startDate, installmentValue, eventId } = createInstallmentsBody.parse(request.body)

    let installments = <CreateInstallmentProps[]>[]

    for(let i = 0; i < installmentQuantity; i++){
      let installmentData
      if(i === 0 && downPayment !== 0) {
        installmentData = {
          installmentDate: dayjs(startDate).add(i, 'M').toISOString(),
          installmentNumber: i + 1,
          installmentValue: downPayment
        }
      } else {
        installmentData = {
          installmentDate: dayjs(startDate).add(i, 'M').toISOString(),
          installmentNumber: i + 1,
          installmentValue
        }
      }

      installments.push(installmentData)
    }
    if(installments !== undefined) {
      installments.map( async (installment) => {

        let parsedInstallmentDate = dayjs(installment.installmentDate)

        await prisma.installments.create({
          data: {
            date: parsedInstallmentDate.toString(),
            installmentNumber: installment.installmentNumber,
            installmentValue: installment.installmentValue,
            eventId: eventId
          }
        })  
      })
    }
  })

  fastify.delete('/installment/', async (request) => {
    const deleteInstallmentsBody = z.object({
      eventId: z.string()
    })

    const {eventId} = deleteInstallmentsBody.parse(request.body)

    await prisma.installments.deleteMany({
      where: {
        eventId
      }
    })
  })
}