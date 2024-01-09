export interface CreateInstallmentProps {
  installmentDate: string,
  installmentNumber: number,
  installmentValue: number
}

export interface FullInstallmentInfo {
  id: string;
  installmentNumber: number;
  date: string; // Ou poderia ser do tipo Date
  installmentValue: number;
  eventId: string;
}
export interface InstallmentSummary {
  firstInstallmentId: string;
  installmentsQuantity: number;
  installmentValue: number;
}