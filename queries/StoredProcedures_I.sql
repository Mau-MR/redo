-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- STORED PROCEDURES DEL SISTEMA: INACTIVOS (I)
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Rutina para la visualización de los beneficiarios inactivos del sistema
USE `REDO_MAKMA`;
DROP procedure IF EXISTS `readInactiveBeneficiaries`;

DELIMITER $$
USE `REDO_MAKMA`$$
CREATE PROCEDURE `readInactiveBeneficiaries` (IN IdBranch INT)
BEGIN
    -- Visualización de los beneficiarios inactivos del sistema
    SELECT b.idBeneficiario Id,
           b.folio Folio,
           b.nombre Nombre,
           b.colonia Colonia,
           DATE_FORMAT(b.fvencimiento, '%d-%m-%Y') Fecha,
           COUNT(fa.beneficiario_idBeneficiario) Falta
    FROM Beneficiario b
             LEFT JOIN FrecuenciaVisita f
                       ON b.frecuenciaVisita_idFrecuenciaVisita = f.idFrecuenciaVisita
             LEFT JOIN GrupoDia g
                       ON b.grupoDia_idGrupoDia = g.idGrupoDia
             LEFT JOIN Sucursal s
                       ON b.sucursal_idSucursal = s.idSucursal
             LEFT JOIN Falta fa
                       ON b.idBeneficiario = fa.beneficiario_idBeneficiario
    WHERE b.status = 0
      AND (b.sucursal_idSucursal = IdBranch
        OR b.sucursal_idSucursal IS NULL)
      AND (fa.status = 1
        OR fa.status IS NULL)
    GROUP BY b.idBeneficiario
    ORDER BY b.folio, Falta ASC;
END$$

DELIMITER ;