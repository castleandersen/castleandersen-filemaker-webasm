use std::f64;
use wasm_bindgen::prelude::*;

#[wasm_bindgen]
pub fn calculate(iterations: usize) -> String {
    format!("{}", iterations)
}

#[wasm_bindgen]
pub fn check_if_prime(n: u64) -> bool {
    // 1. Handle the small numbers first
    if n <= 3 {
        // n <= 1 → not prime, otherwise (2 or 3) → prime
        return n > 1;
    }

    // 2. Eliminate multiples of 2 and 3 right away
    if n.is_multiple_of(2) || n.is_multiple_of(3) {
        return false;
    }

    // 3. Test possible factors of the form 6k ± 1 up to √n
    let mut i = 5;
    let limit = (n as f64).sqrt() as u64;
    while i <= limit {
        if n.is_multiple_of(i) || n.is_multiple_of(i + 2) {
            return false;
        }
        i += 6;
    }

    true
}

/// Generates all prime numbers up to (and including) `max_value`.
/// The result is a single `String` where each prime is separated by "\r".
#[wasm_bindgen]
pub fn get_prime_numbers(max_value: u64) -> String {
    let mut primes: Vec<String> = Vec::new();

    for i in 2..=max_value {
        if check_if_prime(i) {
            primes.push(i.to_string());
        }
    }

    // Join with carriage‑return characters, matching the original `implode("\\r", …)`
    primes.join("\r")
}
