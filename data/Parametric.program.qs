namespace Microsoft.Quantum.Qir.Emission {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;


    @EntryPoint()
    operation BellState() : Int {

        use qubits = Qubit[3];

        Controlled R1([qubits[1]], (PI()/2.0, qubits[0]));
        let res = M(qubits[0]);

        if res == One {
            return 1;
        } else {
            return 0;
        }
    }
}


