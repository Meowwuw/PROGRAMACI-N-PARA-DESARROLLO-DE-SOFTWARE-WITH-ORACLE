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
6. Datos de conexión requeridos
   Estos datos serian:
   
