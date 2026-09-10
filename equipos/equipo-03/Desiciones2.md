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
