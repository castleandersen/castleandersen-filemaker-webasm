use std::f64;
use wasm_bindgen::prelude::*;

// Prime checking utility function from Claris Community post
// https://community.claris.com/en/s/idea/0873w000001QAwcAAG/detail
//
#[wasm_bindgen]
pub fn check_if_prime(n: u32) -> bool {
    if n <= 3 {
        return n > 1;
    }

    if n.is_multiple_of(2) || n.is_multiple_of(3) {
        return false;
    }

    let mut i = 5;
    let limit = (n as f64).sqrt() as u32;
    while i <= limit {
        if n.is_multiple_of(i) || n.is_multiple_of(i + 2) {
            return false;
        }
        i += 6;
    }

    true
}

/// Generates all prime numbers up to (and including) `max_value`.
/// The result is a single `String` where each prime is separated by ",".
#[wasm_bindgen]
pub fn get_prime_numbers(max_value: u32) -> String {
    let mut primes: Vec<String> = Vec::new();

    for i in 2..=max_value {
        if check_if_prime(i) {
            primes.push(i.to_string());
        }
    }

    primes.join(", ")
}
