# Relative-permeability User objects give the correct value
# (note 0.01<=(x=p)<=0.99, and i use seff=p in the aux vars)
# 
# If you want to add another test for another UserObject
# then add the UserObject, add a Function defining the expected result,
# add an AuxVariable and AuxKernel that will record the UserObject's value
# and finally add a NodalL2Error that compares this with the Function

[UserObjects]
  [./RelPermPower]
    type = RichardsRelPermPower
    simm = 0.0
    n = 2
  [../]
  [./RelPermPower5]
    type = RichardsRelPermPower
    simm = 0.0
    n = 5
  [../]
  [./RelPermVG]
    type = RichardsRelPermVG
    simm = 0.0
    m = 0.8
  [../]
  [./RelPermVG1]
    type = RichardsRelPermVG1
    simm = 0.0
    m = 0.8
    scut = 1E-6 # then we get a cubic
  [../]

  # following are unimportant in this test
  [./PPNames]
    type = RichardsPorepressureNames
    porepressure_vars = pressure
  [../]
  [./DensityConstBulk]
    type = RichardsDensityConstBulk
    dens0 = 1000
    bulk_mod = 2E6
  [../]
  [./SeffVG]
    type = RichardsSeff1VG
    m = 0.8
    al = 1E-6
  [../]
  [./RelPermPower_unimportant]
    type = RichardsRelPermPower
    simm = 0.10101
    n = 2
  [../]
  [./Saturation]
    type = RichardsSat
    s_res = 0.054321
    sum_s_res = 0.054321
  [../]
  [./SUPGstandard]
    type = RichardsSUPGstandard
    p_SUPG = 1E5
  [../]
[]

[Functions]
  [./initial_pressure]
    type = ParsedFunction
    value = x
  [../]

  [./answer_RelPermPower]
    type = ParsedFunction
    value = ((n+1)*(x^n))-(n*(x^(n+1)))
    vars = 'n'
    vals = '2'
  [../]
  [./answer_dRelPermPower]
    type = GradParsedFunction
    direction = '1E-4 0 0'
    value = ((n+1)*(x^n))-(n*(x^(n+1)))
    vars = 'n'
    vals = '2'
  [../]
  [./answer_d2RelPermPower]
    type = Grad2ParsedFunction
    direction = '1E-3 0 0'
    value = ((n+1)*(x^n))-(n*(x^(n+1)))
    vars = 'n'
    vals = '2'
  [../]

  [./answer_RelPermPower5]
    type = ParsedFunction
    value = ((n+1)*(x^n))-(n*(x^(n+1)))
    vars = 'n'
    vals = '5'
  [../]
  [./answer_dRelPermPower5]
    type = GradParsedFunction
    direction = '1E-4 0 0'
    value = ((n+1)*(x^n))-(n*(x^(n+1)))
    vars = 'n'
    vals = '5'
  [../]
  [./answer_d2RelPermPower5]
    type = Grad2ParsedFunction
    direction = '1E-5 0 0'
    value = ((n+1)*(x^n))-(n*(x^(n+1)))
    vars = 'n'
    vals = '5'
  [../]

  [./answer_RelPermVG]
    type = ParsedFunction
    value = (x^(0.5))*(1-(1-(x^(1.0/m)))^m)^2
    vars = 'm'
    vals = '0.8'
  [../]
  [./answer_dRelPermVG]
    type = GradParsedFunction
    direction = '1E-4 0 0'
    value = (x^(0.5))*(1-(1-(x^(1.0/m)))^m)^2
    vars = 'm'
    vals = '0.8'
  [../]
  [./answer_d2RelPermVG]
    type = Grad2ParsedFunction
    direction = '1E-5 0 0'
    value = (x^(0.5))*(1-(1-(x^(1.0/m)))^m)^2
    vars = 'm'
    vals = '0.8'
  [../]

  [./answer_RelPermVG1]
    type = ParsedFunction
    value = x^3
  [../]
  [./answer_dRelPermVG1]
    type = GradParsedFunction
    direction = '1E-4 0 0'
    value = x^3
  [../]
  [./answer_d2RelPermVG1]
    type = Grad2ParsedFunction
    direction = '1E-5 0 0'
    value = x^3
  [../]
[]

[AuxVariables]
  [./RelPermPower_Aux]
  [../]
  [./dRelPermPower_Aux]
  [../]
  [./d2RelPermPower_Aux]
  [../]

  [./RelPermPower5_Aux]
  [../]
  [./dRelPermPower5_Aux]
  [../]
  [./d2RelPermPower5_Aux]
  [../]

  [./RelPermVG_Aux]
  [../]
  [./dRelPermVG_Aux]
  [../]
  [./d2RelPermVG_Aux]
  [../]

  [./RelPermVG1_Aux]
  [../]
  [./dRelPermVG1_Aux]
  [../]
  [./d2RelPermVG1_Aux]
  [../]
[]

[AuxKernels]
  [./RelPermPower_AuxK]
    type = RichardsRelPermAux
    variable = RelPermPower_Aux
    relperm_UO = RelPermPower
    seff_var = pressure
  [../]
  [./dRelPermPower_AuxK]
    type = RichardsRelPermPrimeAux
    variable = dRelPermPower_Aux
    relperm_UO = RelPermPower
    seff_var = pressure
  [../]
  [./d2RelPermPower_AuxK]
    type = RichardsRelPermPrimePrimeAux
    variable = d2RelPermPower_Aux
    relperm_UO = RelPermPower
    seff_var = pressure
  [../]

  [./RelPermPower5_AuxK]
    type = RichardsRelPermAux
    variable = RelPermPower5_Aux
    relperm_UO = RelPermPower5
    seff_var = pressure
  [../]
  [./dRelPermPower5_AuxK]
    type = RichardsRelPermPrimeAux
    variable = dRelPermPower5_Aux
    relperm_UO = RelPermPower5
    seff_var = pressure
  [../]
  [./d2RelPermPower5_AuxK]
    type = RichardsRelPermPrimePrimeAux
    variable = d2RelPermPower5_Aux
    relperm_UO = RelPermPower5
    seff_var = pressure
  [../]

  [./RelPermVG_AuxK]
    type = RichardsRelPermAux
    variable = RelPermVG_Aux
    relperm_UO = RelPermVG
    seff_var = pressure
  [../]
  [./dRelPermVG_AuxK]
    type = RichardsRelPermPrimeAux
    variable = dRelPermVG_Aux
    relperm_UO = RelPermVG
    seff_var = pressure
  [../]
  [./d2RelPermVG_AuxK]
    type = RichardsRelPermPrimePrimeAux
    variable = d2RelPermVG_Aux
    relperm_UO = RelPermVG
    seff_var = pressure
  [../]

  [./RelPermVG1_AuxK]
    type = RichardsRelPermAux
    variable = RelPermVG1_Aux
    relperm_UO = RelPermVG1
    seff_var = pressure
  [../]
  [./dRelPermVG1_AuxK]
    type = RichardsRelPermPrimeAux
    variable = dRelPermVG1_Aux
    relperm_UO = RelPermVG1
    seff_var = pressure
  [../]
  [./d2RelPermVG1_AuxK]
    type = RichardsRelPermPrimePrimeAux
    variable = d2RelPermVG1_Aux
    relperm_UO = RelPermVG1
    seff_var = pressure
  [../]
[]

[Postprocessors]
  [./cf_RelPermPower]
    type = NodalL2Error
    function = answer_RelPermPower
    variable = RelPermPower_Aux
  [../]
  [./cf_dRelPermPower]
    type = NodalL2Error
    function = answer_dRelPermPower
    variable = dRelPermPower_Aux
  [../]
  [./cf_d2RelPermPower]
    type = NodalL2Error
    function = answer_d2RelPermPower
    variable = d2RelPermPower_Aux
  [../]

  [./cf_RelPermPower5]
    type = NodalL2Error
    function = answer_RelPermPower5
    variable = RelPermPower5_Aux
  [../]
  [./cf_dRelPermPower5]
    type = NodalL2Error
    function = answer_dRelPermPower5
    variable = dRelPermPower5_Aux
  [../]
  [./cf_d2RelPermPower5]
    type = NodalL2Error
    function = answer_d2RelPermPower5
    variable = d2RelPermPower5_Aux
  [../]

  [./cf_RelPermVG]
    type = NodalL2Error
    function = answer_RelPermVG
    variable = RelPermVG_Aux
  [../]
  [./cf_dRelPermVG]
    type = NodalL2Error
    function = answer_dRelPermVG
    variable = dRelPermVG_Aux
  [../]
  [./cf_d2RelPermVG]
    type = NodalL2Error
    function = answer_d2RelPermVG
    variable = d2RelPermVG_Aux
  [../]

  [./cf_RelPermVG1]
    type = NodalL2Error
    function = answer_RelPermVG1
    variable = RelPermVG1_Aux
  [../]
  [./cf_dRelPermVG1]
    type = NodalL2Error
    function = answer_dRelPermVG1
    variable = dRelPermVG1_Aux
  [../]
  [./cf_d2RelPermVG1]
    type = NodalL2Error
    function = answer_d2RelPermVG1
    variable = d2RelPermVG1_Aux
  [../]
[]
    


#############################################################################
#
# Following is largely unimportant as we're not running an actual similation
#
#############################################################################
[Mesh]
  type = GeneratedMesh
  dim = 1
  nx = 100
  xmin = 0.01
  xmax = 0.99
[]

[Variables]
  [./pressure]
    order = FIRST
    family = LAGRANGE
    [./InitialCondition]
      type = FunctionIC
      function = initial_pressure
    [../]
  [../]
[]
  
[Kernels]
  active = 'richardsf richardst'
  [./richardst]
    type = RichardsMassChange
    porepressureNames_UO = PPNames
    variable = pressure
  [../]
  [./richardsf]
    type = RichardsFlux
    porepressureNames_UO = PPNames
    variable = pressure
  [../]
[]

[Materials]
  [./unimportant_material]
    type = RichardsMaterial
    block = 0
    mat_porosity = 0.1
    mat_permeability = '1E-20 0 0  0 1E-20 0  0 0 1E-20'
    porepressureNames_UO = PPNames
    pressure_vars = pressure
    density_UO = DensityConstBulk
    relperm_UO = RelPermPower_unimportant
    sat_UO = Saturation
    seff_UO = SeffVG
    SUPG_UO = SUPGstandard
    viscosity = 1E-3
    gravity = '0 0 -10'
    linear_shape_fcns = true
  [../]
[]

[Preconditioning]
  [./does_nothing]
    type = SMP
    full = true
    petsc_options = '-snes_converged_reason'
    petsc_options_iname = '-ksp_type -pc_type -snes_atol -snes_rtol -snes_max_it'
    petsc_options_value = 'bcgs bjacobi 1E50 1E50 10000'
  [../]
[]

[Executioner]
  type = Transient
  solve_type = Newton
  num_steps = 1
  dt = 1E-100
[]

[Output]
  linear_residuals = false
  file_base = uo1
  interval = 1
  exodus = true
  perf_log = false
  hidden_variables = pressure
[]
