import { FastifyInstance } from "fastify"
import { z } from "zod"
import { prisma } from "../lib/prisma"
import dayjs from "dayjs"
require('dayjs/locale/pt-br')

export async function appointmentRoutes(fastify: FastifyInstance) {
  fastify.get('/appointment/:appointmentId', async (request) => {
    const getAppointmentParams = z.object({
      appointmentId: z.string()
    })

    const { appointmentId } = getAppointmentParams.parse(request.params)

    const appointment = await prisma.appointment.findUnique({
      where: {
        id: appointmentId
      }
    })

    return appointment
  })

  fastify.delete('/appointment/:appointmentId', async (request) => {
    const getAppointmentParams = z.object({
      appointmentId: z.string()
    })

    const { appointmentId } = getAppointmentParams.parse(request.params)

    await prisma.appointment.delete({
      where: {
        id: appointmentId
      }
    })
  })

  fastify.post('/appointment', async (request) => {

    const createAppointmentBody = z.object({
      appointmentTitle: z.string(),
      appointmentDate: z.string(),
      appointmentLocale: z.string(),
      appointmentTime: z.string(),
      eventId: z.string()
    })

    const { appointmentTitle, appointmentDate, appointmentLocale, appointmentTime, eventId } = createAppointmentBody.parse(request.body)
    
    const parsedAppointmentDate = dayjs(appointmentDate).toISOString()

    const dayOfWeek = dayjs(parsedAppointmentDate).locale('pt-br').format('dddd')

    await prisma.appointment.create({
      data: {
        appointmentTitle,
        date: parsedAppointmentDate.toString(),
        locale: appointmentLocale,
        time: appointmentTime,
        dayOfWeek,
        eventId: eventId
      }
    })
  })

  fastify.get('/appointments/', async (response) => {
    const appointments = await prisma.appointment.findMany({
      select: {
        appointmentTitle: true,
        date: true,
        event: {
          select: {
            hirer: true
          }
        }
      },
       orderBy: {
        date: 'asc'
       }
    })

    return (appointments)
  })

  fastify.put('/appointment/:appointmentId', async (request) => {

    const getAppointmentParams = z.object({
      appointmentId: z.string()
    })

    const updateAppointmentBody = z.object({
      appointmentTitle: z.string(),
      appointmentDate: z.string(),
      appointmentLocale: z.string(),
      appointmentTime: z.string(),
    })

    const { appointmentId } = getAppointmentParams.parse(request.params)
    const { appointmentTitle, appointmentDate, appointmentLocale, appointmentTime } = updateAppointmentBody.parse(request.body)

    const parsedAppointmentDate = dayjs(appointmentDate).toISOString()

    const dayOfWeek = dayjs(parsedAppointmentDate).locale('pt-br').format('dddd')

    await prisma.appointment.update({
      where: {
        id: appointmentId,
      },
      data: {
        appointmentTitle,
        date: parsedAppointmentDate.toString(),
        locale: appointmentLocale,
        time: appointmentTime,
        dayOfWeek,
      }
    })
  })
}