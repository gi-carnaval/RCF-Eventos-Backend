import { FastifyInstance } from "fastify"
import { z } from "zod"
import { prisma } from "../lib/prisma"
import { calcFinalValue } from "../lib/functions"

export async function eventRoutes(fastify: FastifyInstance) {
  fastify.get('/events', async (request) =>{
    const events = await prisma.event.findMany({
      include: {
        eventType: true
      }
    })

    return events
  })
  
  fastify.get('/event/:id', async (request) =>{
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
        totalValue: true,
        appointment: true,
        photographicRegister: true,
        album: true,
        makingOf: true,
        photoShoot: true,
        photoPanel: true,
        installments: {
          orderBy: {
            installmentNumber: 'asc'
          }
        }
      }
      
    })

    return event
  })

  fastify.post('/event', async (request) => {
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
      console.error(error)
    }
  })

  fastify.put('/event/hirer/', async (request) => {
    const updateEventHirerBody = z.object({
      hirer: z.string(),
      eventId: z.string()
    })

    const {hirer, eventId} = updateEventHirerBody.parse(request.body)

    await prisma.event.update({
      where: {
        id: eventId
      }, 
      data: {
        hirer
      }
    })
  })

  fastify.put('/event/photographicRegister/create', async (request) => {
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
      console.error(error)
    }

    await calcFinalValue(eventId)
  })

  fastify.put('/event/album/create', async (request) => {
    const createAlbumBody = z.object({
      size: z.string(),
      pages: z.string(),
      albumCover: z.string(),
      value: z.number(),
      eventId: z.string()
    })

    const {size, pages, albumCover, value, eventId} = createAlbumBody.parse(request.body)

    try {
      await prisma.event.update({
        where: { 
          id: eventId,
        }, 
        data: {
          album: {
            create: {
              albumCover,
              pages,
              size,
              value
            }
          }
        }
      })
    } catch (error) {
      console.error(error)
    }
    await calcFinalValue(eventId)
  })

  fastify.put('/event/photoShoot/create', async (request) => {
    const createPhotoShootBody = z.object({
      value: z.number(),
      eventId: z.string()
    })

    const {value, eventId} = createPhotoShootBody.parse(request.body)

    try {
      await prisma.event.update({
        where: { 
          id: eventId,
        }, 
        data: {
          photoShoot: {
            create: {
              value,
            }
          }
        }
      })
    } catch (error) {
      console.error(error)
    }
    await calcFinalValue(eventId)
  })

  fastify.put('/event/makingOf/create', async (request) => {
    const createMakingOfBody = z.object({
      value: z.number(),
      eventId: z.string()
    })

    const {value, eventId} = createMakingOfBody.parse(request.body)

    try {
      await prisma.event.update({
        where: { 
          id: eventId,
        }, 
        data: {
          makingOf: {
            create: {
              value,
              
            }
          }
        }
      })
    } catch (error) {
      console.error(error)
    }
    await calcFinalValue(eventId)
  })

  fastify.put('/event/photoPanel/create', async (request) => {
    const createPhotoPanelBody = z.object({
      size: z.string(),
      value: z.number(),
      eventId: z.string()
    })

    const {size, value, eventId} = createPhotoPanelBody.parse(request.body)

    try {
      await prisma.event.update({
        where: { 
          id: eventId,
        }, 
        data: {
          photoPanel: {
            create: {
              size,
              value,
            }
          }
        }
      })
    } catch (error) {
      console.error(error)
    }
    await calcFinalValue(eventId)
  })
}