(define-trait nft-trait
  (
    ;; Transfer an NFT from one principal to another
    (transfer (uint principal principal) (response bool uint))

    ;; Get the owner of an NFT
    (get-owner (uint) (response (optional principal) uint))
  )
)
