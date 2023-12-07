import { FastifyInstance } from "fastify";
import { prisma } from "../lib/prisma";
import { z } from "zod";
import { calcFinalValue } from "../lib/functions";

export async function photoShootRoutes(fastify: FastifyInstance) {
  fastify.delete('/event/photoShoot/:photoShootId', async (request) => {
    const getPhotoShootParams = z.object({
      photoShootId: z.string()
    })

    const { photoShootId } = getPhotoShootParams.parse(request.params)

    const eventId = await prisma.photoShoot.findUnique({
      where: {
        id: photoShootId,
      },
      select: {
        Event: {
          select: {
            id: true
          }
        }
      }
    })

    await prisma.photoShoot.delete({
      where: {
        id: photoShootId
      }
    })
    await calcFinalValue(eventId?.Event[0].id)
  })

  fastify.put('/event/photoShoot/:photoShootId', async (request) => {
    const getPhotoShootParams = z.object({
      photoShootId: z.string()
    })

    const updateMakingOfBody = z.object({
      value: z.number()
    })

    const { photoShootId } = getPhotoShootParams.parse(request.params)
    const {value} = updateMakingOfBody.parse(request.body)

    const eventId = await prisma.photoShoot.findUnique({
      where: {
        id: photoShootId,
      },
      select: {
        Event: {
          select: {
            id: true
          }
        }
      }
    })

    await prisma.photoShoot.update({
      where: {
        id: photoShootId
      }, 
      data: {
        value,
      }
    })

    await calcFinalValue(eventId?.Event[0].id)
  })
}