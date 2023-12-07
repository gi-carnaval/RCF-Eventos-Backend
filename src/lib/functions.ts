const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

export async function calcFinalValue(eventId: string | undefined) {
  try {
    // Encontrar o evento pelo ID com todos os dados relacionados
    const oldValues = await prisma.event.findUnique({
      where: {
        id: eventId,
      },
      select: {
        album: {
          select: {
            value: true
          }
        },
        makingOf: {
          select: {
            value: true
          }
        },
        photographicRegister: {
          select: {
            value: true
          }
        },
        photoShoot: {
          select: {
            value: true
          }
        },
        photoPanel: {
          select: {
            value: true
          }
        }
      }
    })

    // Inicializar o valor total do evento como zero
    let valorTotal = 0;
    console.log("Get Values: ", oldValues)
    if (oldValues.photographicRegister) {
      valorTotal += oldValues.photographicRegister.value;
    }
    if (oldValues.album) {
      valorTotal += oldValues.album.value;
    }
    if (oldValues.photoShoot) {
      valorTotal += oldValues.photoShoot.value;
    }
    if (oldValues.makingOf) {
      valorTotal += oldValues.makingOf.value;
    }
    if (oldValues.photoPanel) {
      valorTotal += oldValues.photoPanel.value;
    }

    await prisma.event.update({
      where: { id: eventId },
      data: { valorTotal },
    });

  } catch (error) {
    throw new Error(`Erro ao calcular o valor total do evento: ${error}`);
  }
}