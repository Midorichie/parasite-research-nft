(use-trait nft-trait .nft-trait)

(define-non-fungible-token parasite-research-nft (string-ascii 256))

(define-constant err-unauthorized (err u100))
(define-constant contract-owner tx-sender)

(define-public (mint-parasite-nft 
  (nft-id (string-ascii 256))
  (metadata (string-ascii 512))
)
  (begin
    (asserts! (is-eq tx-sender contract-owner) err-unauthorized)
    (try! (nft-mint? parasite-research-nft nft-id tx-sender))
    (ok nft-id)
  )
)
