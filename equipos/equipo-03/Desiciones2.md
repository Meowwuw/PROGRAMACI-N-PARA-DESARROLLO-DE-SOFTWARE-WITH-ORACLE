PATRICK FREYTAS TAPULLIMA
1. Necesidad
  Ingresar datos de los clientes en la base de dato
   
2.Endpoint
POST/api/clientes

3.Modelo

  public class Cliente {
      private Long id;
      private String nombre;
      private String apellido;
      private Integer telefono;
  
      public Cliente(Long id, String nombre, String apellido, Integer telefono){
          this.id=id;
          this.nombre=nombre;
          this.apellido=apellido;
          this.telefono=telefono;
      }
  
      public Long getId(){ return id;}
  
      public String getNombre(){ return nombre;}
  
      public String getApellido(){ return apellido;}
  
      public Integer getTelefono(){ return telefono;}
  }

4.Flujo 

El flujo seria el siguiente.
-Primero se usaría el controlador de cliente, donde ya estaría usando el modelo de cliente

  public class clienteController {
      private final ClienteService clienteService;
  
      public clienteController(ClienteService clienteService){
          this.clienteService=clienteService;
      }
  
      @GetMapping
      public List<Cliente> listar(){
          return clienteService.listar();
      }
  
  }
-Segundo seria usar el servicio que se usara, en este caso seria registrar los datos del cliente

  @Service
  public class ClienteService {
      private final ClienteRepository clienteRepository;
  
      public ClienteService(ClienteRepository clienteRepository) {
          this.clienteRepository = clienteRepository;
      }
  
      public Cliente registrarCliente(Cliente cliente) {
          return clienteRepository.save(cliente);
      }
  } 
  
-Tercero se hace la conexion la base de datos mediante repositorio

  public interface ClienteRepository extends JpaRepository<Cliente, Long> {

  }


5. SQL necesario

  INSERT INTO cliente (telefono, nombre, apellido,dni)
  VALUES
  ('987654321', 'Juan', 'Perez','12345678'),

6. Datos de conexión requeridos
  Estos datos serian:

  spring.datasource.url=jdbc:postgresql://localhost:5432/mi_base_de_datos
  spring.datasource.username=postgres
  spring.datasource.password=TU_PASSWORD
  
  spring.jpa.hibernate.ddl-auto=update
  spring.jpa.show-sql=true
  spring.jpa.properties.hibernate.format_sql=true

-----------------------------------------------------------------------------------------



DAVID SANGAMA SAENZ

1. Necesidad
  Registrar una nueva cancha de vóley en la base de datos, para que quede disponible y se pueda usar luego en las reservas y horarios.

2. Endpoint
POST /api/canchas

3. Modelo

  public class Cancha {
      private Long id;
      private int numeroCancha;

      public Cancha(Long id, int numeroCancha){
          this.id = id;
          this.numeroCancha = numeroCancha;
      }

      public Long getId(){ return id; }

      public int getNumeroCancha(){ return numeroCancha; }
  }

4. Flujo

El flujo sería el siguiente.
-Primero se usaría el controlador de cancha, donde ya estaría usando el modelo de cancha

  @RestController
  @RequestMapping("/api/canchas")
  public class canchaController {
      private final CanchaService canchaService;

      public canchaController(CanchaService canchaService){
          this.canchaService = canchaService;
      }

      @PostMapping
      public Cancha registrar(@RequestBody Cancha cancha){
          return canchaService.registrarCancha(cancha);
      }

      @GetMapping
      public List<Cancha> listar(){
          return canchaService.listar();
      }
  }

-Segundo sería usar el servicio que se usará, en este caso sería registrar los datos de la cancha

  @Service
  public class CanchaService {
      private final CanchaRepository canchaRepository;

      public CanchaService(CanchaRepository canchaRepository) {
          this.canchaRepository = canchaRepository;
      }

      public Cancha registrarCancha(Cancha cancha) {
          return canchaRepository.save(cancha);
      }

      public List<Cancha> listar() {
          return canchaRepository.findAll();
      }
  }

-Tercero se hace la conexión a la base de datos mediante repositorio

  public interface CanchaRepository extends JpaRepository<Cancha, Long> {

  }

5. SQL necesario

  INSERT INTO cancha (numero_cancha)
  VALUES
  (3);

6. Datos de conexión requeridos
  Estos datos serían:

  spring.datasource.url=jdbc:postgresql://localhost:5432/mi_base_de_datos
  spring.datasource.username=postgres
  spring.datasource.password=TU_PASSWORD

  spring.jpa.hibernate.ddl-auto=update
  spring.jpa.show-sql=true
  spring.jpa.properties.hibernate.format_sql=true

-----------------------------------------------------------------------------------------

