import { FastifyInstance } from "fastify";
import { prisma } from "../lib/prisma";
import { z } from "zod";
import { calcFinalValue } from "../lib/functions";

export async function makingOfRoutes(fastify: FastifyInstance) {
  fastify.delete('/event/makingOf/:makingOfId', async (request) => {
    const getAlbumParams = z.object({
      makingOfId: z.string()
    })

    const { makingOfId } = getAlbumParams.parse(request.params)

    const eventId = await prisma.makingOf.findUnique({
      where: {
        id: makingOfId,
      },
      select: {
        Event: {
          select: {
            id: true
          }
        }
      }
    })

    await prisma.makingOf.delete({
      where: {
        id: makingOfId
      }
    })
    await calcFinalValue(eventId?.Event[0].id)
  })

  fastify.put('/event/makingOf/:makingOfId', async (request) => {
    const getMakingOfParams = z.object({
      makingOfId: z.string()
    })

    const updateMakingOfBody = z.object({
      value: z.number()
    })

    const { makingOfId } = getMakingOfParams.parse(request.params)
    const {value} = updateMakingOfBody.parse(request.body)

    const eventId = await prisma.makingOf.findUnique({
      where: {
        id: makingOfId,
      },
      select: {
        Event: {
          select: {
            id: true
          }
        }
      }
    })

    await prisma.makingOf.update({
      where: {
        id: makingOfId
      }, 
      data: {
        value,
      }
    })

    await calcFinalValue(eventId?.Event[0].id)
  })
}