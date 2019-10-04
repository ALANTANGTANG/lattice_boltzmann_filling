function calculate_surface_curvature_test()

flat = [ ...
    0 0 0; ...
    -1 -1 0; ...
    1 -1 0; ...
    1 1 0; ...
    -1 1 0; ...
    ];
inside = [ ...
    0 0 0; ...
    -1 -1 1; ...
    1 -1 1; ...
    1 1 1; ...
    -1 1 1; ...
    ];
outside = [ ...
    0 0 0; ...
    -1 -1 -1; ...
    1 -1 -1; ...
    1 1 -1; ...
    -1 1 -1; ...
    ];
outside_double = 2 * outside;
missing = [ ...
    0 0 0; ...
    1 -1 -1; ...
    0 1 -1; ...
    -1 -1 -1; ...
    nan nan nan; ...
    ];
missing_ck = [ ...
    0 0 0; ...
    1 -1 -1; ...
    0 1 -1; ...
    -1 -1 -1; ...
    0 -1 -1; ...
    ];
points = cat( 3, flat, inside, outside, outside_double, missing, missing_ck );
points = permute( points, [ 1 3 2 ] );

n_flat = [ ...
    0 0 1; ...
    0 0 1; ...
    0 0 1; ...
    0 0 1; ...
    0 0 1; ...
    ];
n_inside = [ ...
    0 0 1; ...
    1 1 1; ...
    -1 1 1; ...
    -1 -1 1; ...
    1 -1 1; ...
    ];
n_outside = [ ...
    0 0 1; ...
    -1 -1 1; ...
    1 -1 1; ...
    1 1 1; ...
    -1 1 1; ...
    ];
n_outside_double = n_outside;
n_missing = [ ...
    0 0 1; ...
    1 -1 1; ...
    0 1 1; ...
    -1 -1 1; ...
    nan nan nan; ...
    ];
n_missing_ck = [ ...
    0 0 1; ...
    -1 1 1; ...
    0 1 1; ...
    -1 -1 1; ...
    0 -1 1; ...
    ];
normals = cat( 3, n_flat, n_inside, n_outside, n_outside_double, n_missing, n_missing_ck );
normals = permute( normals, [ 1 3 2 ] );
normals = normals ./ vecnorm( normals, 2, 3 );

COUNT = 1;
points = repmat( points, [ 1 COUNT 1 ] );
normals = repmat( normals, [ 1 COUNT 1 ] );

point_count = numel( points( :, :, 1 ) );
center_point_count = size( points, 2 );

fprintf( "center_points: %i\n", center_point_count );
t = tic;
mean_normals = calculate_mean_normals( normals );
toc( t );

t = tic;
inds = sort_points_counterclockwise( points, mean_normals );
toc( t );

points_s = points( inds );
normals_s = normals( inds );

t = tic;
k_s = calculate_surface_curvature( points_s, normals_s );
toc( t );

k = calculate_surface_curvature( points, normals );

end

