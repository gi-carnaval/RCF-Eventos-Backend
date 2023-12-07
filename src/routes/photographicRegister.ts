import { FastifyInstance } from "fastify";
import { prisma } from "../lib/prisma";
import { z } from "zod";
import { calcFinalValue } from "../lib/functions";

export async function photographicRegisterRoutes(fastify: FastifyInstance) {
  fastify.delete('/event/photographicRegister/:photographicRegisterId', async (request) => {
    const getPhotographicRegisterParams = z.object({
      photographicRegisterId: z.string()
    })

    const { photographicRegisterId } = getPhotographicRegisterParams.parse(request.params)

    const eventId = await prisma.photographicRegister.findUnique({
      where: {
        id: photographicRegisterId,
      },
      select: {
        Event: {
          select: {
            id: true
          }
        }
      }
    })
    
    await prisma.photographicRegister.delete({
      where: {
        id: photographicRegisterId
      }
    })
    await calcFinalValue(eventId?.Event[0].id)
  })

  fastify.put('/event/photographicRegister/:photographicRegisterId', async (request) => {
    const getPhotographicRegisterParams = z.object({
      photographicRegisterId: z.string()
    })

    const updatePhotographicRegisterBody = z.object({
      professionalQuantity: z.string(),
      photoAverage: z.string(),
      value: z.number(),
    })

    const { photographicRegisterId } = getPhotographicRegisterParams.parse(request.params)
    const {photoAverage, professionalQuantity, value} = updatePhotographicRegisterBody.parse(request.body)

    const eventId = await prisma.photographicRegister.findUnique({
      where: {
        id: photographicRegisterId,
      },
      select: {
        Event: {
          select: {
            id: true
          }
        }
      }
    })
    
    await prisma.photographicRegister.update({
      where: {
        id: photographicRegisterId
      }, 
      data: {
        photoAverage,
        professionalQuantity,
        value
      }
    })

    await calcFinalValue(eventId?.Event[0].id)
  })
}