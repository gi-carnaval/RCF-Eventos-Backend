import { FastifyInstance } from "fastify"
import { z } from "zod"
import { prisma } from "../lib/prisma"

export async function eventRoutes(fastify: FastifyInstance) {
  fastify.get('/events', async (request) =>{
    const events = await prisma.event.findMany({
      orderBy: {id: 'asc'},
      include: {
        eventType: true
      }
    })

    return events
  })
  
  fastify.get('/events/:id', async (request) =>{
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
        eventType: true,
        appointment: true,
        photographicRegister: true,
        album: true
      }
      
    })

    return event
  })

  fastify.post('/events', async (request) => {
    const createEventBody = z.object({
      hirer: z.string(),
      eventType: z.string(),
    })

    const { hirer, eventType } = createEventBody.parse(request.body)
    const createdAt = new Date()
    
    try {
      await prisma.event.create({
        data: {
          hirer,
          createdAt,
          eventTypeId: eventType
        }
      })
    } catch (error) {
      console.log(error)
    }
  })

  fastify.put('/events/photographicRegister/create', async (request) => {
    const createPhotographicRegisterBody = z.object({
      professionalQuantity: z.string(),
      photoAverage: z.string(),
      value: z.number(),
      eventId: z.string()
    })

    const {photoAverage, professionalQuantity, value, eventId} = createPhotographicRegisterBody.parse(request.body)

    try {
      await prisma.event.update({
        where: { 
          id: eventId,
        }, 
        data: {
          photographicRegister: {
            create: {
              photoAverage,
              professionalQuantity,
              value
            }
          }
        }
      })
    } catch (error) {
      
    }
  })
}