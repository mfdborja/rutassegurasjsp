package controlador;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Properties;

public class Datos {

    private static Datos miDatos = null;
    public static String ipServidor = "localhost";
    public static int puertoServidor = 0;
    public static String bannerTiempo = "";
    public static String apigooglemaps="";
    public static String apigoogleanalytics="";
    

    public static Datos getDatos() {
        if (miDatos == null) {
            miDatos = new Datos();
        }

        return miDatos;
    }

    private Datos() {
        File archivoconf = new File(System.getProperty("/home/rutasseguras")+"/"+"configuracionrutasseguras");
        Properties prop = new Properties();
        if (archivoconf.exists()) {
            try {
                prop.load(new FileInputStream(archivoconf));
                ipServidor = prop.getProperty("ipServidor");
                puertoServidor = Integer.parseInt(prop.getProperty("puertoServidor"));
                bannerTiempo = prop.getProperty("bannerTiempo");

                apigooglemaps=prop.getProperty("apigooglemaps");
                apigoogleanalytics=prop.getProperty("apigoogleanalytics");
            } catch (IOException ex) {
                System.err.println("No se puede cargar el archivo de configuración. " + ex.getMessage());
            }

        } else {
           //Establecer valores
            ipServidor="";
            prop.setProperty("ipServidor", ipServidor);
            puertoServidor=0;
            prop.setProperty("puertoServidor", ""+puertoServidor);
            bannerTiempo="<script type='text/javascript' src='http://www.aemet.es/es/eltiempo/prediccion/municipios/launchwidget/granada-id18087?w=g2p01110010ohmefefefw170z207x4f86d9t95b6e9r0s6n1'></script><noscript><a target='_blank' style='font-weight: bold;font-size: 10px;' href='http://www.aemet.es/es/eltiempo/prediccion/municipios/granada-id18087'>El Tiempo. Consulte la predicción de la AEMET para Granada</a></noscript>";
            prop.setProperty("bannerTiempo",bannerTiempo);
            apigooglemaps="";
            prop.setProperty("apigooglemaps", apigooglemaps);
            apigoogleanalytics="";
            prop.setProperty("apigoogleanalytics", apigoogleanalytics);
            //Guardar
            try {
                if(!(new File(System.getProperty("user.home"))).exists()){
                    new File(System.getProperty("user.home")).mkdir();
                    
                }
                prop.store(new FileOutputStream(archivoconf), "Configuración de conexión con el servidor de rutas seguras.");
            } catch (Exception ex) {
                System.err.println("No se puede crear el archivo de configuración. " + ex.getMessage());

            }
            System.out.println("Se ha creado un archivo de configuración en: "+archivoconf.getAbsolutePath());
        }

    }
}
