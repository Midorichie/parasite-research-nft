(define-map researcher-credentials 
  principal 
  { 
    institution: (string-ascii 128), 
    research-level: (string-ascii 64),
    expiration: uint 
  }
)

(define-constant contract-owner tx-sender)
(define-constant err-unauthorized (err u300))
(define-constant err-invalid-credentials (err u301))

(define-public (register-researcher 
  (researcher principal)
  (institution (string-ascii 128))
  (research-level (string-ascii 64))
)
  (begin
    (asserts! (is-eq tx-sender contract-owner) err-unauthorized)
    (asserts! (> (len institution) u0) err-invalid-credentials)
    (asserts! (> (len research-level) u0) err-invalid-credentials)
    (map-set researcher-credentials 
      researcher 
      { 
        institution: institution, 
        research-level: research-level,
        expiration: (+ block-height u1000) 
      }
    )
    (ok true)
  )
)

(define-read-only (is-valid-researcher (researcher principal))
  (match (map-get? researcher-credentials researcher)
    credentials 
      (> (get expiration credentials) block-height)
    false
  )
)
