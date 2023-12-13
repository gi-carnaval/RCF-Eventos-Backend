require('dotenv/config');
import cors from '@fastify/cors'

import Fastify from 'fastify'
import { eventRoutes } from "./routes/event";
import { eventTypesRoutes } from "./routes/eventType";
import { appointmentRoutes } from "./routes/appointment";
import { photographicRegisterRoutes } from './routes/photographicRegister';
import { albumRoutes } from './routes/album';
import { reportRoutes } from './routes/reports';
import path from 'path';
import fastifyStatic from '@fastify/static';
import { makingOfRoutes } from './routes/makingOf';
import { photoShootRoutes } from './routes/photoShoot';
import { photoPanelRoutes } from './routes/photoPanel';
import { installmentsRoutes } from './routes/installments';

const start = async () => {
  const fastify = Fastify({
      logger: true, 
  })

  try{
      await fastify.register(cors, {
          origin: true
      }, )
      
      await fastify.register(require("@fastify/view"), {
        engine: {
          ejs: require("ejs"),
        },
      })

      fastify.register(fastifyStatic, {
        root: path.join(__dirname, '../', '../'),
        
      })

      await fastify.register(eventRoutes)
      await fastify.register(eventTypesRoutes)
      await fastify.register(appointmentRoutes)
      await fastify.register(photographicRegisterRoutes)
      await fastify.register(albumRoutes)
      await fastify.register(reportRoutes)
      await fastify.register(makingOfRoutes)
      await fastify.register(photoShootRoutes)
      await fastify.register(photoPanelRoutes)
      await fastify.register(installmentsRoutes)

      await fastify.listen({ port: 3030 })
      console.log("Server Started")
      console.log("listening on port 3030")
  } catch (err) {
      fastify.log.error(err)

      process.exit(1)
  }
}
start()