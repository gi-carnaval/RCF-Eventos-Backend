import { FastifyInstance } from "fastify";
import { prisma } from "../lib/prisma";
import { z } from "zod";
import { calcFinalValue } from "../lib/functions";

export async function albumRoutes(fastify: FastifyInstance) {
  fastify.delete('/event/album/:albumId', async (request) => {
    const getAlbumParams = z.object({
      albumId: z.string()
    })

    const { albumId } = getAlbumParams.parse(request.params)

    const eventId = await prisma.album.findUnique({
      where: {
        id: albumId,
      },
      select: {
        Event: {
          select: {
            id: true
          }
        }
      }
    })

    await prisma.album.delete({
      where: {
        id: albumId
      }
    })
    await calcFinalValue(eventId?.Event[0].id)
  })

  fastify.put('/event/album/:albumId', async (request) => {
    const getAlbumParams = z.object({
      albumId: z.string()
    })

    const updateAlbumBody = z.object({
      size: z.string(),
      pages: z.string(),
      albumCover: z.string(),
      value: z.number()

    })

    const { albumId } = getAlbumParams.parse(request.params)
    const {albumCover, pages, size, value} = updateAlbumBody.parse(request.body)

    const eventId = await prisma.album.findUnique({
      where: {
        id: albumId,
      },
      select: {
        Event: {
          select: {
            id: true
          }
        }
      }
    })

    await prisma.album.update({
      where: {
        id: albumId
      }, 
      data: {
        albumCover,
        pages,
        size,
        value,
      }
    })
    await calcFinalValue(eventId?.Event[0].id)
  })

}