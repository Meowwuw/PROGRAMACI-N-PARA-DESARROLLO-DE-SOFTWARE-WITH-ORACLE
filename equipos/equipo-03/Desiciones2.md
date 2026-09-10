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

PACHO LOPEZ LEO STEEP
1. Necesidad
  Registrar horarios en la base de dato
   
2.Endpoint
POST/api/horarios

3.Modelo
  public class Horario {
    private Long id;
    private String hora;
    private double precio;

    public Horario(Long id, String hora, double precio) {
        this.id = id;
        this.hora = hora;
        this.precio = precio;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getHora() {
        return hora;
    }

    public void setHora(String hora) {
        this.hora = hora;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }
}
  

4.Flujo 

El flujo seria el siguiente.
-Primero se usaría el controlador de cliente, donde ya estaría usando el modelo de cliente

@RestController
@RequestMapping("/api/horarios")
public class HorarioController {

    private final HorarioService horarioService;

    public HorarioController(HorarioService horarioService) {
        this.horarioService = horarioService;
    }

    @GetMapping
    public List<Horario> listar() {
        return horarioService.listar();
    }
}
  
-Segundo seria usar el servicio que se usara, en este caso seria registrar los datos del cliente

  public HorarioService(HorarioRepository horarioRepository) {
      this.horarioRepository = horarioRepository;
  }

  public Horario registrarHorario(Horario horario) {
      return horarioRepository.save(horario);
  }
  
-Tercero se hace la conexion la base de datos mediante repositorio

  public interface HorarioRepository extends JpaRepository<Horario, Long> {

  }


5. SQL necesario

  INSERT INTO horario (hora, precio)
  VALUES
  ('08:00:00', 20.00),

6. Datos de conexión requeridos
  Estos datos serian:

  spring.datasource.url=jdbc:postgresql://localhost:5432/mi_base_de_datos
  spring.datasource.username=postgres
  spring.datasource.password=TU_PASSWORD
  
  spring.jpa.hibernate.ddl-auto=update
  spring.jpa.show-sql=true
  spring.jpa.properties.hibernate.format_sql=true

-----------------------------------------------------------------------------------------

ESAU PECHO ZARATE
1. Necesidad Ingresar datos de los clientes en la base de datos
2. Endpoint POST/api/reservas
3. Modelo
   
public class Reserva { private int id; private int id_cliente; private int id_horario; private int id_cancha; private String fecha;

    public Reserva(int id, int id_cliente, int id_horario, int id_cancha, String fecha){
        this.id=id;
        this.id_cliente=id_cliente;
        this.id_horario=id_horario;
        this.id_cancha=id_cancha;
        this.fecha=fecha;
    }
    public int getId(){return id;}
    public void setId(int id){this.id=id;}
   
    public int getId_cliente(){return id_cliente;}
    public void setId_cliente(int id_cliente){this.id_cliente=id_cliente;}
   
    public int getId_horario(){return id_horario;}
    public void setId_horario(int id_horario){this.id_horario=id_horario;}
   
    public int getId_cancha(){return id_cancha;}
    public void setId_cancha(int id_cancha){this.id_cancha=id_cancha;}
   
    public String getFecha(){return fecha;}
    public void setFecha(String fecha){this.fecha=fecha;}
}

4. Flujo

El flujo seria el siguiente. -Primero se usaría el controlador de reserva, donde ya estaría usando el modelo de reserva
public class reservaController {private final ReservaService reservaService;

    public reservaController(ReservaService reservaService){
        this.reservaService=reservaService;
    }
    
    @GetMapping
    public List<Reserva> listar(){
        return reservaService.listar();
    }
}
-Segundo seria usar el servicio que se usara, en este caso seria registrar los datos de la reserva
@Service
public class ReservaService {private List<Reserva> reservas = new ArrayList<>();

    public List<Reserva> listar(){
        return List.of(
                new Reserva(1,123456,123,0001,"01/01/26"),
                new Reserva(2,654321,456,0002,"02/02/26"),
                new Reserva(3,162534,789,0003,"03/03/26")
        );
    }

    public void guardar(Reserva reserva){
        reservas.add(reserva);
    }

    public void eliminar(int id) {
        reservas.removeIf(reserva -> reserva.getId() == id);
    }
}
-Tercero se hace la conexion la base de datos mediante repositorio
public interface ReservaRepository extends JpaRepository<Reserva, Long> {

}

5. SQL necesario
   INSERT INTO reserva (id_cliente, id_horario, id_cancha, fecha)
   
6. Datos de conexión requeridos
   Estos datos serian:
spring.datasource.url=jdbc:postgresql://localhost:5432/mi_base_de_datos spring.datasource.username=postgres spring.datasource.password=TU_PASSWORD

spring.jpa.hibernate.ddl-auto=update spring.jpa.show-sql=true spring.jpa.properties.hibernate.format_sql=true
