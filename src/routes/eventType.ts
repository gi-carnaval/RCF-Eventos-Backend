import { FastifyInstance } from "fastify"
import { z } from "zod"
import { prisma } from "../lib/prisma"

export async function eventTypesRoutes(fastify: FastifyInstance) {
  fastify.post('/eventTypes', async (request) => {
    const createEventTypesBody = z.object({
      type: z.string().toLowerCase(),
    })

    const { type } = createEventTypesBody.parse(request.body)

    try {
      await prisma.eventType.create({
        data: {
          type
        }
      })
    } catch (error) {
      console.error(error)
    }
  })
  
  fastify.get('/eventTypes', async (request) =>{
    const eventTypes = await prisma.eventType.findMany({
      orderBy: {id: 'asc'}
    })

    return eventTypes
  })
}