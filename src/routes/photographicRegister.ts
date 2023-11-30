import { FastifyInstance } from "fastify";
import { prisma } from "../lib/prisma";
import { z } from "zod";

export async function photographicRegisterRoutes(fastify: FastifyInstance) {
  fastify.delete('/photographicRegister/:photographicRegisterId', async (request) => {
    const getPhotographicRegisterParams = z.object({
      photographicRegisterId: z.string()
    })

    const { photographicRegisterId } = getPhotographicRegisterParams.parse(request.params)

    await prisma.photographicRegister.delete({
      where: {
        id: photographicRegisterId
      }
    })
  })
}