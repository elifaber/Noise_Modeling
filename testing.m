sources = [
    create_source(75,15,0), 
    create_source(80,5,5), 
    create_source(85,5,0),
    create_source(100,-25,25),
    create_source(80,-6,-2)
];
x_range = -50:.5:50;
y_range = -50:.5:50;

stc = 1;
absorb = .1;

walls = [
    create_wall([-10,24],[0,24],stc,absorb),
    create_wall([-10,-50],[0,-50],stc,absorb),
    create_wall([-10,-50],[-10,24],stc,absorb),
    create_wall([0,24],[0,-50],25,absorb)

];
plot_noise(sources, x_range, y_range,75,walls);
plot_noise (sources(1:3));



sources = [
    create_source(75,15,0) 
];

walls = [
    create_wall([12,-20],[12,20],stc,absorb),

];

plot_noise(sources, x_range, y_range,75,walls);


