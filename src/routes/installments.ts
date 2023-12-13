import { FastifyInstance } from "fastify"
import { z } from "zod"
import { prisma } from "../lib/prisma"
import dayjs from "dayjs"
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
      installmentNumber: z.number(),
      date: z.string(),
      installmentValue: z.number(),
      eventId: z.string()
    })


    const ArraySchema = z.array(createInstallmentsBody)

    function validarArray(dados: unknown): { installmentNumber: number; date: string; installmentValue: number, eventId: string }[] | undefined {
      try {
        const resultado = ArraySchema.parse(dados);
        return resultado;
      } catch (error: any ) {
        response.statusCode = 500
        response.send(error.message)
        return undefined;
      }
    }

    const arrayValidado = validarArray(request.body)

    if(arrayValidado !== undefined) {
      arrayValidado.map( async (installment) => {

        let parsedInstallmentDate = dayjs(installment.date)

        await prisma.installments.create({
          data: {
            date: parsedInstallmentDate.toString(),
            installmentNumber: installment.installmentNumber,
            installmentValue: installment.installmentValue,
            eventId: installment.eventId
          }
        })  
      })
    }
  })
}