-- =====================================================================
-- SORTEO DE EQUIPOS EN VIVO  ·  Clase 03  ·  PIAD-201
-- ---------------------------------------------------------------------
-- =====================================================================

SELECT NTILE(6) OVER (ORDER BY random()) AS equipo,
       aprendiz
FROM (VALUES
    ('ABARCA DIAZ, John Benjamin'),
    ('AGUILAR PARIONA, Diego Nicolas'),
    ('AMASIFUEN RUIZ, Angel Gabriel'),
    ('ANGULO NOLORBE, Edgar Jesus'),
    ('ARAPA HUAMAN, Erick'),
    ('AREVALO VILLACORTA, Christian Esteban Jonell'),
    ('CARIHUA LINARES, Juan Jamer'),
    ('CHASNAMOTE SINACAY, Videz Augusto'),
    ('FREYTAS TAPULLIMA, Patrick Witmar'),
    ('GARCIA VASQUEZ, Ani Luz'),
    ('GONZALES SANGAMA, Alex Jonas'),
    ('GONZALES VERDE, Jose Luis'),
    ('LOZADA ESCOBAR, Genesis Ximena'),
    ('NAHUINRIPA QUISPE, Susan Aracely'),
    ('PACHO LOPEZ, Leo Steep'),
    ('PECHO ZARATE, Esau Ademir'),
    ('PINEDO SAAVEDRA, Angel Martin'),
    ('SAAVEDRA HIDALGO, Harim Jander'),
    ('SALDANA BRIONES, Nixon Roel'),
    ('SANGAMA SAENZ, David Leonardo'),
    ('TREJO AQUINO, Fredi'),
    ('VARGAS BRITTO, Ardey Uday'),
    ('VILLACORTA MONTELUISA, Dan Apolo'),
    ('ZEGARRA LOPEZ, Jhoau Alexander')
) AS salon(aprendiz)
ORDER BY equipo, aprendiz;
