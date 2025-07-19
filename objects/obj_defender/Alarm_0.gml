// Begin role behavior after reaction delay
switch (role) {
    case "zone":
    case "man":
        state = "cover";
        break;
    case "blitz":
        state = "blitz";
        break;
    case "spy":
        state = "spy";
        break;
}
