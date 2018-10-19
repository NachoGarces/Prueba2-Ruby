file = File.open('alumnos.csv', 'r')
data = file.readlines.map(&:chomp)
file.close
arr = []
data.each do |e|
  arr.push e.split(', ')
end

def def_menu
  puts ' |------------------------------------------|'
  puts ' |                   Menu                   |'
  puts ' |------------------------------------------|'
  puts ' |1. Nombres y promedio                     |'
  puts ' |2. Inasistencias totales                  |'
  puts ' |3. Aprobados (nota 5 por defecto)         |'
  puts ' |4. Terminar el programa                   |'
  puts ' |------------------------------------------|'
  puts ' |Ingrese el numero de lo que desea realizar|'
  puts ' |------------------------------------------|'
end

def espera
  puts "\nPrecione enter para volver al programa"
  gets.chomp
end

def validador(nada)
  puts "\n****Ingrese una opcion valida entre 1 y 4****" if nada < 1 || nada > 4
end

def nom_pro(opcion1)
  opcion1.each do |alum|
    notas = alum[1..5]
    sum = 0
    notas.each do |num|
      sum += num.to_i
    end
    file = File.open('promedios.csv', 'a')
    file.puts "#{alum.first}:  #{sum / 5.to_f}\n\n"
    file.close
  end
end

def in_alm(opcion2)
  a = 0
  opcion2.each do |alum|
    notas = alum[1..5]
    a += notas.count('A') if notas.include?('A')
  end
  puts "La cantidad de inasistencias totales es #{a}"
end

def apro(opcion3, prom)
  puts "Los aprobados con nota #{prom} o superior son:"
  opcion3.each do |alum|
    notas = alum[1..5]
    sum = 0
    notas.each do |num|
      sum += num.to_i
    end
    me = sum / 5.to_f
    puts "#{alum.first}:  #{me}" if me >= prom
  end
end

op_usuario = 0
while op_usuario != 4
  def_menu
  op_usuario = gets.chomp.to_i
  validador(op_usuario)
  case op_usuario
  when 1
    puts "\nOpcion uno: Nombres y promedios de los alumnos"
    nom_pro(arr)
    puts 'Se guardaron los datos en el archivo "promedios.csv"'
    espera
  when 2
    puts "\nOpcion dos: Inasistencias de los alumnos"
    in_alm(arr)
    espera
  when 3
    puts "\nOpcion tres: Aprobados, selecciona la nota de aprobacion"
    nota = gets.chomp.to_i
    nota = 5 if nota.zero?
    apro(arr, nota)
    espera
  when 4
    puts "\nOpcion cuatro: Fin del programa\n\n"
  end
end
