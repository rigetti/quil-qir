namespace Microsoft.Quantum.Qir.Emission {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;

    // operation SetQubitState(desired : Result, target : Qubit) : Unit {
    //     if desired != M(target) {
    //         X(target);
    //     }
    // }

    @EntryPoint()
    operation BellState(nrIter : Int) : Int {

        mutable numOnes = 0;
        use (q0, q1) = (Qubit(), Qubit());
        // SetQubitState(Zero, q0);
        // SetQubitState(Zero, q1);

        H(q0);
        CNOT(q0,q1);
        let res = M(q0);

        // Count the number of ones we saw:
        if res == One {
            set numOnes += 1;
        }

        // SetQubitState(Zero, q0);
        // SetQubitState(Zero, q1);
        
        return numOnes;
    }
}


