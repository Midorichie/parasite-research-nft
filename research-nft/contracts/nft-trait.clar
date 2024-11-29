(define-trait nft-trait
  (
    ;; Function to transfer an NFT
    (transfer (uint principal principal) (response bool uint))
    ;; Function to get the owner of an NFT
    (get-owner (uint) (response (optional principal) uint))
  )
)
