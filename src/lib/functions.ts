import { FullInstallmentInfo, InstallmentSummary } from "../types/installments";

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
    let totalValue = 0;
    console.log("Get Values: ", oldValues)
    if (oldValues.photographicRegister) {
      totalValue += oldValues.photographicRegister.value;
    }
    if (oldValues.album) {
      totalValue += oldValues.album.value;
    }
    if (oldValues.photoShoot) {
      totalValue += oldValues.photoShoot.value;
    }
    if (oldValues.makingOf) {
      totalValue += oldValues.makingOf.value;
    }
    if (oldValues.photoPanel) {
      totalValue += oldValues.photoPanel.value;
    }

    await prisma.event.update({
      where: { id: eventId },
      data: {
        totalValue
      }
    });

  } catch (error) {
    throw new Error(`Erro ao calcular o valor total do evento: ${error}`);
  }
}
export async function getAllInstallments(eventId: string): Promise<FullInstallmentInfo[]>  {
    const installments = await prisma.installments.findMany({
      where: {
        eventId
      },
      orderBy: {
        installmentNumber: 'asc'
      }
    })
    return installments
}

export async function getFirstInstallmentIdAndQuantityOfInstalls(installments: FullInstallmentInfo[]): Promise<InstallmentSummary> {
  const firstInstallmentId = installments[0].id
  const installmentValue = installments[0].installmentValue
  const installmentsQuantity = installments.length

  return {firstInstallmentId, installmentsQuantity, installmentValue}
}

