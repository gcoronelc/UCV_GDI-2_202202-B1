

USE EduTec;
GO

CREATE PROCEDURE USP_LISTADO
AS
  SELECT * FROM CURSO;
GO


-- Con usuario Neymar
-- =================================

SELECT * FROM CURSO;
GO

exec USP_LISTADO
GO




