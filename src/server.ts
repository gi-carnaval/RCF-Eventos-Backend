require('dotenv/config');
import cors from '@fastify/cors'

import Fastify from 'fastify'
import { eventRoutes } from "./routes/event";
import { eventTypesRoutes } from "./routes/eventType";
import { appointmentRoutes } from "./routes/appointment";
import { photographicRegisterRoutes } from './routes/photographicRegister';

const start = async () => {
  const fastify = Fastify({
      logger: true,
  })

  try{
      await fastify.register(cors, {
          origin: true
      })

      await fastify.register(eventRoutes)
      await fastify.register(eventTypesRoutes)
      await fastify.register(appointmentRoutes)
      await fastify.register(photographicRegisterRoutes)

      await fastify.listen({ port: 3030 })
      console.log("Server Started")
      console.log("listening on port 3030")
  } catch (err) {
      fastify.log.error(err)

      process.exit(1)
  }
}
start()