import { FastifyInstance } from "fastify";
import { prisma } from "../lib/prisma";
import { z } from "zod";
import { calcFinalValue } from "../lib/functions";

export async function photoPanelRoutes(fastify: FastifyInstance) {
  fastify.delete('/event/photoPanel/:photoPanelId', async (request) => {
    const getPhotoPanelParams = z.object({
      photoPanelId: z.string()
    })

    const { photoPanelId } = getPhotoPanelParams.parse(request.params)

    const eventId = await prisma.photoPanel.findUnique({
      where: {
        id: photoPanelId,
      },
      select: {
        Event: {
          select: {
            id: true
          }
        }
      }
    })

    await prisma.photoPanel.delete({
      where: {
        id: photoPanelId
      }
    })
    await calcFinalValue(eventId?.Event[0].id)
  })

  fastify.put('/event/photoPanel/:photoPanelId', async (request) => {
    const getPhotoPanelParams = z.object({
      photoPanelId: z.string()
    })

    const updateMakingOfBody = z.object({
      value: z.number()
    })

    const { photoPanelId } = getPhotoPanelParams.parse(request.params)
    const {value} = updateMakingOfBody.parse(request.body)

    const eventId = await prisma.photoPanel.findUnique({
      where: {
        id: photoPanelId,
      },
      select: {
        Event: {
          select: {
            id: true
          }
        }
      }
    })

    await prisma.photoPanel.update({
      where: {
        id: photoPanelId
      }, 
      data: {
        value,
      }
    })

    await calcFinalValue(eventId?.Event[0].id)
  })
}