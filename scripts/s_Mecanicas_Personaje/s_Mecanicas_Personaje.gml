/// @desc Mecanicas del Videojuego.

//IMPUT DEL JUGADOR

//keyboard_check() - comprueba que se esté pulsando una tecla del teclado
//vk_x - comprueba que sea esa la tecla que se está pulsando. 
//keyboard_check_pressed() - comprueba que se haya pulsado una unica vez la tecla.

key_left = keyboard_check(vk_left);
key_right = keyboard_check(vk_right);
key_jump = keyboard_check_pressed(vk_space);

//Ejemplo de cómo funciona.
// x = keyboard_check(x) - esto comprueba que se haya tecleado la tecla x, si se a pulsado,
//el programa devuelve TRUE, sino devuelve FALSE. Lo mismo con keyboard_check_pressed().
// vk = virtual key.

//CALCULO DEL MOVIMIENTO

//var (significa que la variable que la sigue solo se puede utilizar de forma local en este
//evento step y no fuera de el.)

var move = key_right - key_left;
//TRUE = 1 / FALSE = 0
// Si move = 1 (mover derecha), si move = 0 (mover izquierda)

hsp = move * walksp;
//La velocidad horizontal = movimiento * velocidad al caminar.
//hsp = (-)1 * 4 - el personaje se moverá horizontalmente a la derecha/izquierda 4 fps.

//Caida del personaje. Empieza en 0 y va aumentando con el tiempo.
vsp = vsp + grv;

//SALTO
//Si los dos son TRUE se ejecuta la acción.
if (place_meeting(x,y+1,objectWall)) && (key_jump)
{
	vsp = -jumpsp;
	//jumpsp es negativa porque la grafica de GM empieza en el 4º cuadrante.
	//La X, y la Y empiezan arriba a la izquierda. 
}

//COLISIÓN HORIZONTAL
if (place_meeting(x + hsp,y,objectWall))
{
	//mientras no haya colisión, seguir moviendose.
	while (!place_meeting(x + sign(hsp), y , objectWall))
	{
		//Nos movemos un pixel a izquierda o derecha.
		x = x + sign(hsp);
	}
	hsp = 0;
}
x = x + hsp;

//place_meeting() - crea una copia virtual de las variables y las posiciona en 
//las coordenadas introducidas, comprobando si hemos tocado o no objectWall.

//sign() - redondea cualquier valor introducido a 1, -1 o 0.

//COLISIÓN VERTICAL
if (place_meeting(x,y + vsp,objectWall))
{
	while (!place_meeting(x, y + sign(vsp) , objectWall))
	{
		y = y + sign(vsp);
	}
	vsp = 0;
}
y = y + vsp;
