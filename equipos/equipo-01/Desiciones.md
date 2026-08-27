
Problematica: 
--
En los últimos tres años, el barrio ha crecido muchísimo y casi todas las familias tienen al menos un perrito o gatito. 
Sin embargo, no existe ninguna clínica veterinaria formal a menos de 45 minutos de distancia. Esto ha generado tres 
problemas graves:

1- Urgencias mal atendidas: En una zona cálida, la proliferación de garrapatas (que causan erliquia) y los golpes de calor 
son comunes. Un viaje de 45 minutos en una emergencia suele ser fatal para los peluditos.

2- Falta de control sanitario: Los dueños olvidan las fechas de vacunación y desparasitación porque apuntan todo en cartillas 
de cartón que terminan perdiéndose, lo que ha provocado pequeños brotes de parvovirus en los parques del barrio.

3- Historiales médicos perdidos: A veces los vecinos traen veterinarios a domicilio, pero cada uno receta algo distinto 
porque no hay un lugar centralizado que guarde el historial médico de la mascota.


--------------------------------------------------------------
Aqui la explicacion del por que de cada tabla creada en el scrip:
-------------------------------------------------------------------------

--------------------------------------------------------------
1. Tabla duenos (Propietarios de las mascotas)
--------------------------------------------------------------
Guarda los datos de contacto de las personas responsables de los pacientes.

id_dueno SERIAL PRIMARY KEY: Es el identificador único de cada dueño. SERIAL 
genera un número entero autoincrementa (1, 2, 3...) de forma automática cada vez 
que registras a alguien. PRIMARY KEY garantiza que nunca haya dos dueños con el mismo ID.

nombre VARCHAR(100) NOT NULL: Guarda el nombre completo. VARCHAR(100) reserva espacio variable 
de hasta 100 caracteres. NOT NULL exige que este dato siempre exista (no puedes registrar un dueño sin nombre).

telefono VARCHAR(20): Guarda el número telefónico. Se usa VARCHAR en lugar de INT porque los teléfonos 
pueden incluir signos (+), guiones o ceros a la izquierda. Es opcional (sin NOT NULL).


direccion TEXT: Permite escribir la dirección completa. Se usa TEXT porque no impone un límite 
rígido de caracteres, ideal para explicaciones detalladas de ubicacinn.

--------------------------------------------------------------
2. Tabla mascotas (Los pacientes)
--------------------------------------------------------------
Registra a los animales que se atienden en la clínica y los vincula directamente con su dueño.

id_mascota SERIAL PRIMARY KEY: Identificador único e irrepetible para cada mascota.

id_dueno INT NOT NULL REFERENCES duenos(id_dueno) ON DELETE CASCADE: Es una Clave Foránea (FK) 
que conecta la mascota con su dueño.

¿Por qué funciona? ON DELETE CASCADE significa que si eliminas a un dueño de la base de datos, automáticamente
se borrarán todas sus mascotas asociadas. Esto evita que queden "mascotas huérfanas" sin un dueño válido en el sistema.

nombre VARCHAR(50) NOT NULL: Nombre de la mascota 

especie VARCHAR(50) NOT NULL: Tipo de animal

raza VARCHAR(50): Raza de la mascota. Es opcional ya que no todas las mascotas la tienen definida 

fecha_nacimiento DATE: Almacena únicamente año, mes y día. Permite calcular la edad exacta de la mascota 
en cualquier momento.

--------------------------------------------------------------
3. Tabla veterinarios (El personal médico)
--------------------------------------------------------------

Almacena la información de los profesionales de la clínica.

id_veterinario SERIAL PRIMARY KEY: Código o número de ficha único para cada médico.

nombre VARCHAR(100) NOT NULL: Nombre completo del profesional.

especialidad VARCHAR(100): Área médica, Opcional por si es médico general.

telefono VARCHAR(20): Número de contacto del médico.

--------------------------------------------------------------
4. Tabla consultas (Citas y atenciones médicas)
--------------------------------------------------------------

Esta es una tabla central que une al paciente con el médico que lo atendió y registra los detalles de la visita.

id_consulta SERIAL PRIMARY KEY: Número de folio único para la cita médica.

id_mascota INT NOT NULL REFERENCES mascotas(id_mascota) ON DELETE RESTRICT: Vincula la consulta a una mascota.

¿Por qué ON DELETE RESTRICT? A diferencia de los dueños, si intentas borrar una mascota 
que ya tiene historial de consultas, la base de datos bloqueará la eliminación. Esto protege 
el historial clínico y contable de la veterinaria.

id_veterinario INT NOT NULL REFERENCES veterinarios(id_veterinario) ON DELETE RESTRICT: Vincula al veterinario responsable. Si el médico renuncia y borras su perfil, RESTRICT evitará que perdamos el registro de quién atendió las consultas pasadas.

fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP: Guarda la fecha con hora, minuto y segundo. 
DEFAULT CURRENT_TIMESTAMP toma la hora exacta del sistema en el momento de crear el registro,
así no tienes que ingresarla manualmente.

diagnostico TEXT: Espacio ilimitado para que el médico redacte el informe clínico de la consulta.

costo_base DECIMAL(10, 2) NOT NULL DEFAULT 0.00: Cobro fijo por la revisión inicial. DECIMAL(10, 2)
es el tipo de dato correcto para dinero (10 dígitos en total, 2 decimales) porque evita los errores 
de redondeo típicos de los números flotantes.

--------------------------------------------------------------
5. Tabla servicios (Catálogo de prestaciones)
--------------------------------------------------------------

Funciona como un menú o lista de precios de los servicios adicionales que ofrece la clínica (vacunas, limpiezas dentales, exámenes de laboratorio, etc.).

id_servicio SERIAL PRIMARY KEY: Identificador único de cada servicio prestado.

nombre_servicio VARCHAR(100) NOT NULL: Nombre del servicio

precio DECIMAL(10, 2) NOT NULL: Valor monetario exacto del servicio.

--------------------------------------------------------------
6. Tabla detalle_consulta_servicio (Relación Muchos a Muchos / N:M)
--------------------------------------------------------------

En una consulta se pueden aplicar varios servicios (ej. vacunar y desparasitar a la vez), y un mismo servicio se realiza en miles de consultas diferentes. 
Para resolver esta relación de "Muchos a Muchos", se crea esta tabla intermedia.

id_detalle SERIAL PRIMARY KEY: Identificador único de este ítem facturado.

id_consulta INT NOT NULL REFERENCES consultas(id_consulta) ON DELETE CASCADE: Indica a qué consulta pertenece este servicio. Si la consulta se anula o borra, 
se eliminan sus detalles asociados en cascada (ON DELETE CASCADE).

id_servicio INT NOT NULL REFERENCES servicios(id_servicio) ON DELETE RESTRICT: Indica qué servicio del catálogo se aplicó. Usa RESTRICT para no poder borrar 
un servicio del catálogo si ya fue cobrado en consultas anteriores.

observaciones TEXT: Permite anotar detalles específicos de esa aplicación 
