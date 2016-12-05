<%@page import="controlador.Datos"%>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&key=<%=Datos.apigooglemaps%>&sensor=true&libraries=places" ></script>

<script>
    <%!
        String puntosRuta;
        String[] puntosExtension;
        Double fsup, finf, fizq, fder;
        boolean hayFrontera;
        String[] iconos;
        String temp;

    %>
    <%
        puntosRuta = (String) request.getAttribute("cadptsgoogle");
        puntosExtension = (String[]) request.getAttribute("arcos");

        hayFrontera = false;
        fsup = finf = fizq = fder = 0.0;
        if (request.getAttribute("fsup") != null) {
            fsup = new Double((double) request.getAttribute("fsup"));
            finf = new Double((double) request.getAttribute("finf"));
            fizq = new Double((double) request.getAttribute("fizq"));
            fder = new Double((double) request.getAttribute("fder"));
            hayFrontera = true;
        }

        iconos = (String[]) request.getAttribute("iconos");

    %>
    /**
     * Variables globales
     */
    var map;
    var geocoder;
    var allMarkers = [];
    var rectangle;
    /**
     * Se ejecuta al cargar la página
     */
    function initialize() {
        //Geocodificador
        geocoder = new google.maps.Geocoder();
        //Estilo
        var estilo = [
            {
                "featureType": "landscape",
                "stylers": [
                    {
                        "hue": "#FFBB00"
                    },
                    {
                        "saturation": 43.400000000000006
                    },
                    {
                        "lightness": 37.599999999999994
                    },
                    {
                        "gamma": 1
                    }
                ]
            },
            {
                "featureType": "road.highway",
                "stylers": [
                    {
                        "hue": "#FFC200"
                    },
                    {
                        "saturation": -61.8
                    },
                    {
                        "lightness": 45.599999999999994
                    },
                    {
                        "gamma": 1
                    }
                ]
            },
            {
                "featureType": "road.arterial",
                "stylers": [
                    {
                        "hue": "#FF0300"
                    },
                    {
                        "saturation": -100
                    },
                    {
                        "lightness": 51.19999999999999
                    },
                    {
                        "gamma": 1
                    }
                ]
            },
            {
                "featureType": "road.local",
                "stylers": [
                    {
                        "hue": "#FF0300"
                    },
                    {
                        "saturation": -100
                    },
                    {
                        "lightness": 52
                    },
                    {
                        "gamma": 1
                    }
                ]
            },
            {
                "featureType": "water",
                "stylers": [
                    {
                        "hue": "#0078FF"
                    },
                    {
                        "saturation": -13.200000000000003
                    },
                    {
                        "lightness": 2.4000000000000057
                    },
                    {
                        "gamma": 1
                    }
                ]
            },
            {
                "featureType": "poi",
                "stylers": [
                    {
                        "hue": "#00FF6A"
                    },
                    {
                        "saturation": -1.0989010989011234
                    },
                    {
                        "lightness": 11.200000000000017
                    },
                    {
                        "gamma": 1
                    }
                ]
            }
        ];

        /*[
         {
         "featureType": "administrative",
         "elementType": "labels.text.fill",
         "stylers": [
         {
         "color": "#0c0b0b"
         }
         ]
         },
         {
         "featureType": "landscape",
         "elementType": "all",
         "stylers": [
         {
         "color": "#f2f2f2"
         }
         ]
         },
         {
         "featureType": "poi",
         "elementType": "all",
         "stylers": [
         {
         "visibility": "off"
         }
         ]
         },
         {
         "featureType": "road",
         "elementType": "all",
         "stylers": [
         {
         "saturation": -100
         },
         {
         "lightness": 45
         }
         ]
         },
         {
         "featureType": "road",
         "elementType": "labels.text.fill",
         "stylers": [
         {
         "color": "#090909"
         }
         ]
         },
         {
         "featureType": "road.highway",
         "elementType": "all",
         "stylers": [
         {
         "visibility": "simplified"
         }
         ]
         },
         {
         "featureType": "road.arterial",
         "elementType": "labels.icon",
         "stylers": [
         {
         "visibility": "off"
         }
         ]
         },
         {
         "featureType": "transit",
         "elementType": "all",
         "stylers": [
         {
         "visibility": "off"
         }
         ]
         },
         {
         "featureType": "water",
         "elementType": "all",
         "stylers": [
         {
         "color": "#d4e4eb"
         },
         {
         "visibility": "on"
         }
         ]
         },
         {
         "featureType": "water",
         "elementType": "geometry.fill",
         "stylers": [
         {
         "visibility": "on"
         },
         {
         "color": "#fef7f7"
         }
         ]
         },
         {
         "featureType": "water",
         "elementType": "labels.text.fill",
         "stylers": [
         {
         "color": "#9b7f7f"
         }
         ]
         },
         {
         "featureType": "water",
         "elementType": "labels.text.stroke",
         "stylers": [
         {
         "color": "#fef7f7"
         }
         ]
         }
         ];*/
        //Propiedades del mapa
        var mapOptions = {
            zoom: 15,
            center: new google.maps.LatLng(37.174147, -3.598741),
            /**
             MapTypeId.ROADMAP muestra la vista de mapa de carretera predeterminada.
             MapTypeId.SATELLITE muestra imágenes de satélite de Google Earth.
             MapTypeId.HYBRID muestra una mezcla de vistas normales y de satélite.
             MapTypeId.TERRAIN muestra un mapa físico basado en información del relieve.
             */
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            rotateControl: false,
            panControl: false,
            scaleControl: false,
            streetViewControl: true,
            zoomControl: false,
            styles: estilo
        };
        //Mapa
        map = new google.maps.Map(document.getElementById('map-canvas'),
                mapOptions);


        //Añadir rectángulo frontera
        if (<%= hayFrontera%>) {
            var fbounds = new google.maps.LatLngBounds(
                    //Sur oeste
                    new google.maps.LatLng(<%=finf%>, <%=fizq%>),
                    //Nor este
                    new google.maps.LatLng(<%=fsup%>, <%=fder%>));
            map.fitBounds(fbounds);
            var frontera = new google.maps.Rectangle({
                strokeColor: '#00FF00',
                strokeOpacity: 1,
                strokeWeight: 3,
                fillColor: '#00FF00',
                fillOpacity: 0.075,
                map: map,
                bounds: fbounds
            });
            //Función información al hacer click
            google.maps.event.addListener(frontera, 'click', function (e) {
                var lati = e.latLng.lat();
                var longi = e.latLng.lng();
                var mostrar = true;
                //Comprobar frontera click

                if (mostrar) {
                    var texto = '<object type="text/html" data="<%= pageContext.getServletContext().getContextPath()%>/infopunto?lat=' + lati + '&lon=' + longi + '" ></object>';
                    var infowindow = new google.maps.InfoWindow({
                        content: texto,
                        maxWidth: 350
                    });
                    var marker = new google.maps.Marker({
                        position: e.latLng,
                        map: map
                    });
                    google.maps.event.addListener(infowindow, 'closeclick', function () {
                        marker.setMap(null); //removes the marker
                    });
                    infowindow.open(map, marker);
                }


            });
        }

        //Iconos alertas
    <%if (iconos != null) {
            //Para cada icono
            for (int i = 0; i < iconos.length; i++) {
                String[] icono = iconos[i].split("#");
                int tipo = Integer.parseInt(icono[1]);
                int usuario = Integer.parseInt(icono[5]);
    %>

        //Poner icono
        var ico<%= i%> = new google.maps.Marker();
        ico<%= i%>.setPosition(new google.maps.LatLng(<%=icono[3]%>, <%=icono[4]%>));
    <%if (tipo == 0) {%>
        ico<%= i%>.setTitle("Calle cortada");
    <%} else if (tipo == 1) {%>
        ico<%= i%>.setTitle("Acera ocupada");
    <%} else if (tipo == 2) {%>
        ico<%= i%>.setTitle("Trabajos en la vía");
    <%} else if (tipo == 3) {%>
        ico<%= i%>.setTitle("Trabajos en la acera");
    <%} else if (tipo == 4) {%>
        ico<%= i%>.setTitle("Andamiaje en la acera");
    <%} else if (tipo == 5) {%>
        ico<%= i%>.setTitle("Calle cortada al tráfico");
    <%} else if (tipo == 25) {%>
        ico<%= i%>.setTitle("Control de policía");
    <%} else if (tipo == 30) {%>
        ico<%= i%>.setTitle("Comercio adherido");
    <%} else if (tipo == 100) {%>
        ico<%= i%>.setTitle("Monitor de colegio");
    <%} else if (tipo == 101) {%>
        ico<%= i%>.setTitle("Colegio");
    <%}%>
        //Distintos tipos de iconos
        ico<%= i%>.setIcon('<%="personalizacion/iconos/" + tipo + ".png"%>');
        ico<%= i%>.setMap(map);

    <%temp = "<p style='min-width:150px;'>" + icono[2] + "<p>";
        if (request.getSession(false) != null) {
            if (request.getSession(false).getAttribute("id") != null) {
                if (((Integer) request.getSession(false).getAttribute("id")) == usuario || ((String) request.getSession(false).getAttribute("tipo")).equalsIgnoreCase("administrador")) {
                    temp += "<br/><a href='" + pageContext.getServletContext().getContextPath() + "/borrarIcono?id=" + icono[0] + "'> Borrar </a>";
                }
            }
        }%>

        //Añadir ventana emergente con la info
        var iw<%= i%> = new google.maps.InfoWindow({
            content: "<%=temp%>"
        }
        );
        google.maps.event.addListener(ico<%= i%>, 'click', function () {
            iw<%= i%>.open(map, ico<%= i%>);
        });
    <%}
        }%>






        //Buscador autocompletitivo
        var input = document.getElementById('busqueda');
        var autocomplete = new google.maps.places.Autocomplete(input);
        map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
        map.controls[google.maps.ControlPosition.TOP_LEFT].push(document.getElementById('busquedaIr'));
        
        autocomplete.addListener('place_changed', function() {
            //Cuando haces enter o click en la lista de lugares
            ponerPin();
        });


        //Ruta visible           
        var path = [<%= puntosRuta%>];
        new google.maps.Polyline({
            map: map,
            path: path,
            strokeColor: '#00FF00',
            strokeOpacity: 1.0,
            geodesic: true,
            strokeWeight: 3,
            zIndex: 1
        });
        //Ajustar mapa a la ruta
        var limites = new google.maps.LatLngBounds(0, 0);
        for (x = 0; x < path.length; x++)
        {
            elemento = path[x];
            limites.extend(elemento);
        }

        //Tamaño del mapa
        map.fitBounds(limites);
        //Marcadores
        if (path.length > 0) {
            //Poner marcador

            var n = path.length - 1;
            //Poner marcador
            var marker1 = new google.maps.Marker({
                map: map,
                position: path[0],
                title: "Salida",
                draggable: false,
                animation: google.maps.Animation.BOUNCE,
                zIndex: 10
            });
            var marker2 = new google.maps.Marker({
                map: map,
                position: path[n],
                title: "Destino",
                draggable: false,
                animation: google.maps.Animation.BOUNCE,
                zIndex: 11
            });
            //Guardar marcador
            map.setMarker(marker1, marker2);
        }
    }//Fin iniciar



    /**
     * Lo ejecuta el geoposicionador
     * @returns {undefined}
     */
    function ponerPin() {
        var address = document.getElementById('busqueda').value;

        //Borrar caja


        geocoder.geocode({'address': address}, function (results, status) {
            if (status == google.maps.GeocoderStatus.OK && allMarkers.length < 2) {

                //Centrar mapa en el punto
                map.setCenter(results[0].geometry.location);
                map.setZoom(16);
                //Poner marcador
                var marker = new google.maps.Marker({
                    map: map,
                    position: results[0].geometry.location,
                    title: (allMarkers.length == 0) ? "Salida" : "Destino",
                    draggable: true,
                    animation: google.maps.Animation.DROP
                });
                //Guardar marcador
                allMarkers.push(marker);
                //map.setMarker(marker);

                if (allMarkers.length === 1) {
                    document.getElementById('busqueda').placeholder = 'Introduzca destino';
                    document.getElementById('busqueda').value = '';
                } 
                if (allMarkers.length === 2) {
                    document.getElementById('busqueda').placeholder = 'Elija tipo y seguridad de ruta';
                    document.getElementById('busqueda').value = '';
                    document.getElementById('busqueda').disabled=true;
                }
            } else {
                //Si da error no se avisa - Dirección muy mal puesta
                //alert('Geocode was not successful for the following reason: ' + status);
            }

        });
    }

    function generarRuta() {
        if (allMarkers.length > 1) {
            var georuta = "";
            for (i = 0; i < allMarkers.length; i++) {
                var markerLatLon = allMarkers[i].getPosition();
                georuta += markerLatLon.lat() + ";" + markerLatLon.lng() + "@";
            }//Fin listar marcadores
            //Poner info en el form
            document.getElementsByName("coordenadas")[0].value = georuta;
            document.forms["generarRuta"].submit();
        }
    }

    function submitenter(myfield, e)
    {
        var keycode;
        if (window.event)
            keycode = window.event.keyCode;
        else if (e)
            keycode = e.which;
        else
            return true;
        if (keycode == 13)
        {
            ponerPin();
            return false;
        }
        else
            return true;
    }

    function centrar() {
        var address = document.getElementById('busqueda').value;
        geocoder.geocode({'address': address}, function (results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                //Borrar rectángulo antiguo si hubiera
                if (rectangle != null) {
                    rectangle.setMap(null);
                }
                //Zoom del mapa a la calle
                map.fitBounds(results[0].geometry.viewport);
                // Define the rectangle and set its editable property to true.
                rectangle = new google.maps.Rectangle({
                    bounds: results[0].geometry.viewport,
                    editable: true,
                    draggable: true,
                    strokeColor: '#FF0000',
                    strokeOpacity: 0.8,
                    strokeWeight: 2,
                    fillColor: '#0000FF',
                    fillOpacity: 0.35
                });
                rectangle.setMap(map);
                google.maps.event.addListener(rectangle, 'click', nuevosvaloresseg);
            }
        });
    }
    function rotarizq() {

        var heading = map.getHeading() || 0;
        map.setHeading(heading - 90);
        return true;
    }
    function rotarder() {
        var heading = map.getHeading() || 0;
        map.setHeading(heading + 90);
        return true;
    }

    function submitentercentrar(myfield, e)
    {
        var keycode;
        if (window.event)
            keycode = window.event.keyCode;
        else if (e)
            keycode = e.which;
        else
            return true;
        if (keycode == 13)
        {
            centrar();
            return false;
        }
        else
            return true;
    }



    function nuevosvaloresseg() {
        if (rectangle != null) {
            rectangle.setEditable(false);
            rectangle.setDraggable(false);
            var limites = rectangle.getBounds();
            var supder = limites.getNorthEast();
            var infizq = limites.getSouthWest();
            //Lados del rectángulo
            var sup = supder.lat();
            var der = supder.lng();
            var inf = infizq.lat();
            var izq = infizq.lng();
            //Nueva ventana con el formulario
            var opciones = "toolbar=no, location=no, directories=no, status=yes, menubar=yes, resizable=yes, width=500, height=400";
            window.open("<%= pageContext.getServletContext().getContextPath()%>/infozonaform.jsp?sup=" + sup + "&inf=" + inf + "&izq=" + izq + "&der=" + der + "\"", "Seguridad de zona", opciones);
        }

    }

    function acercade() {
        window.location = '<%= pageContext.getServletContext().getContextPath()%>/acercade.jsp';
    }

    google.maps.event.addDomListener(window, 'load', initialize);
</script>