namespace Microsoft.Quantum.Qir.Emission {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;


    @EntryPoint()
    operation BellState() : Result {

        use qubits = Qubit[3];

        Rx(PI()/4.0, qubits[0]);
        CNOT(qubits[1], qubits[0]);
        let res = M(qubits[0]);

        return res;
    }
}