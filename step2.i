s0 = -10e6 # Negative sign for compression in MOOSE
K = 0.6

[Mesh]
  file = FaultMesh.msh
[]

[GlobalParams]
  displacements = 'disp_x disp_y'
[]

[Physics/SolidMechanics/QuasiStatic]
  [all]
    strain = SMALL
    generate_output = 'vonmises_stress stress_xx stress_xy stress_yy stress_zz strain_xx strain_xy strain_yy strain_zz'
    add_variables = true
    block = 'leftrock rightrock'
    material_output_family = 'MONOMIAL'
    material_output_order = 'CONSTANT'
    eigenstrain_names = ini_stress 
  []
[]

[Functions]
    [sigma_h]
      type = ParsedFunction
      symbol_names = 'K s0'
      symbol_values = '${K} ${s0}'
      expression = K*s0
    []
  []

[BCs]
  [top_stress_y]
    type = Pressure
    variable = disp_y
    boundary = 'top'
    factor = ${s0} 
  []
  [bottom_stress_x]
    type = Pressure
    variable = disp_y
    boundary = 'bottom'
    factor = ${s0} 
  []
  [left_stress_x]
    type = Pressure
    variable = disp_x
    boundary = 'left'
    function = sigma_h 
  []
  [right_stress_x]
    type = Pressure
    variable = disp_x
    boundary = 'right'
    function = sigma_h
  []
  [cavityPressure_x]
    type = Pressure
    boundary = 'wall'
    variable = disp_x
    factor = 0 #Pa
  []
  [cavityPressure_y]
    type = Pressure
    boundary = 'wall'
    variable = disp_y
    factor = 0 # Pa
  []
[]

[Materials]
  [elasticity]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 10000e6 
    poissons_ratio = 0.3 
    block = 'leftrock rightrock'
  []
  [stress]
    type = ComputeLinearElasticStress
    block = 'leftrock rightrock'
  []
  [strain_from_initial_stress]
    type = ComputeEigenstrainFromInitialStress
    initial_stress = '6e6 0 0 0 10e6 0 0 0 6e6'
    eigenstrain_name = ini_stress
    block = 'leftrock rightrock'
  []
[]

[Contact]
    [fault_contact]
      primary = 'fault'
      secondary = 'fault'
      model = coulomb
      formulation = penalty
      penalty = 10e9
      normalize_penalty = true
    []
  []

[Preconditioning]
  [SMP]
    type = SMP
    full = true
  []
[]

[Executioner]
  type = Steady 
  solve_type = NEWTON
  l_abs_tol = 1e-50
  l_tol = 1e-10
  l_max_its = 10000
  line_search = none
[]

# [VectorPostprocessors]
#   [point_sample]
#     type = PositionsFunctorValueSampler
#     functors = 'disp_x disp_y stress_xx stress_xy stress_yy strain_xx strain_xy strain_yy'
#     positions = 'all_elements'
#     sort_by = 'x'
#     execute_on = TIMESTEP_END
#   []
#   [fault_sample]
#     type = PositionsFunctorValueSampler
#     functors = 'disp_x disp_y stress_xx stress_xy stress_yy'
#     positions = 'fault'
#     execute_on = TIMESTEP_END
#   []
# []

# [Positions]
#   [all_elements]
#     type = ElementCentroidPositions
#   []
# []

[Outputs]
  exodus = true
  csv = true
[]