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
