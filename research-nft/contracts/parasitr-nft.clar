(define-trait nft-trait
  (
    (transfer (string-ascii 256 principal principal) (response bool uint))
    (get-owner (string-ascii 256) (response (optional principal) uint))
  )
)

(define-non-fungible-token parasite-research-nft (string-ascii 256))

(define-constant contract-owner tx-sender)
(define-constant err-unauthorized (err u100))
(define-constant err-already-minted (err u101))

(define-read-only (get-parasite-nft-owner (nft-id (string-ascii 256)))
  (nft-get-owner? parasite-research-nft nft-id)
)

(define-public (mint-parasite-nft 
  (nft-id (string-ascii 256))
  (metadata (string-ascii 512))
)
  (begin 
    (asserts! (is-eq tx-sender contract-owner) err-unauthorized)
    (asserts! (is-none (get-parasite-nft-owner nft-id)) err-already-minted)
    (try! (nft-mint? parasite-research-nft nft-id tx-sender))
    (ok nft-id)
  )
)

(define-public (transfer 
  (token-id (string-ascii 256))
  (sender principal)
  (recipient principal)
)
  (begin
    (asserts! (is-eq tx-sender sender) err-unauthorized)
    (try! (nft-transfer? parasite-research-nft token-id sender recipient))
    (ok true)
  )
)
