include("kern_proc.jl")

d = 10
n = [50, 100, 500]

λ = rand(d)

cross_kern_procs = Array(Proc, 0)
push!(cross_kern_procs, KernelTest(SEArd(λ, 1.0), d, GaussianProcesses.crossKern))
push!(cross_kern_procs, KernelTest(Mat12Ard(λ, 1.0), d, GaussianProcesses.crossKern))
push!(cross_kern_procs, KernelTest(Mat32Ard(λ, 1.0), d, GaussianProcesses.crossKern))
push!(cross_kern_procs, KernelTest(Mat52Ard(λ, 1.0), d, GaussianProcesses.crossKern))
push!(cross_kern_procs, KernelTest(RQArd(λ, 1.0, 1.0), d, GaussianProcesses.crossKern))
cross_kern_table = run(cross_kern_procs, n)

grad_stack_procs = Array(Proc, 0)
push!(grad_stack_procs, KernelTest(SEArd(λ, 1.0), d, GaussianProcesses.grad_stack))
push!(grad_stack_procs, KernelTest(Mat12Ard(λ, 1.0), d, GaussianProcesses.grad_stack))
push!(grad_stack_procs, KernelTest(Mat32Ard(λ, 1.0), d, GaussianProcesses.grad_stack))
push!(grad_stack_procs, KernelTest(Mat52Ard(λ, 1.0), d, GaussianProcesses.grad_stack))
push!(grad_stack_procs, KernelTest(RQArd(λ, 1.0, 1.0), d, GaussianProcesses.grad_stack))
grad_stack_table = run(grad_stack_procs, n)

println("\ncrossKern calculations")
show(cross_kern_table)

println("\grad_stack calculations")
show(grad_stack_table)
