%Creates several point sources of sound
sources = [
    create_source(75,15,0), 
    create_source(80,5,5), 
    create_source(85,5,0),
    create_source(100,-25,25),
];
% Defines a range for plotting
x_range = -50:.5:50;
y_range = -50:.5:50;

%Defines the STC and absorption coefficient for the walls
stc = 30;
absorb = .3;

%Creates the walls
walls = [
    create_wall([-10,24],[0,24],stc,absorb),
    create_wall([-10,-50],[0,-50],stc,absorb),
    create_wall([-10,-50],[-10,24],stc,absorb),
    create_wall([0,24],[0,-50],25,absorb)

];

%Plots according to the input above (many walls and sources)
plot_noise(sources, x_range, y_range,75,walls);
plot_noise (sources(1:3));


%Redefines the sources
sources = [
    create_source(100,15,0) 
];

%Redefines the walls
walls = [
    create_wall([12,-20],[12,20],stc,absorb),

];

%Creates an example to demonstrate one wall close to one point source
plot_noise(sources, x_range, y_range,75,walls);


