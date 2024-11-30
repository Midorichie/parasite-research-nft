(use-trait nft-trait .nft-trait)

(define-map listings
  { nft-contract: principal, token-id: (string-ascii 256) }
  { price: uint, seller: principal }
)

(define-public (list-nft
  (nft-contract principal)
  (token-id (string-ascii 256))
  (price uint))
  (begin
    (asserts! (is-contract nft-contract) (err u400))
    (asserts! (<= (len token-id) u256) (err u401))
    (asserts! (> price u0) (err u402))
    (let ((owner (unwrap! (contract-call? nft-contract get-owner token-id) (err u403))))
      (asserts! (is-eq owner tx-sender) (err u404))
      (map-insert listings
        { nft-contract: nft-contract, token-id: token-id }
        { price: price, seller: tx-sender })
      (ok true)
    )
  )
)
