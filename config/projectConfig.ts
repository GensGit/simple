const projectConfig = {
  nftName: 'Mytoken',

  nftSymbol: 'MYT',

  maxSupply: 1500,

  maxMintAmountPerTxn: 5,

  mintCost: process.env.NODE_ENV === 'production' ? 100 : 0.025,

  networkName:
    process.env.NODE_ENV === 'production'
      ? 'Ethereum Mainnet' // 'Ethereum Mainnet'
      : 'Rinkeby Testnet', // 'Rinkeby Testnet'

  chainName: 'ETH', // 'ETH'

  chainId: process.env.NODE_ENV === 'production' ? 1 : 4, // Ethereum (1), Rinkeby (4)

  siteDomain: 'https://simple-one.vercel.app/',

  siteUrl:
    process.env.NODE_ENV === 'production'
      ? `https://simple-one.vercel.app/`
      : 'https://simple-one.vercel.app/',

  twitterUsername: '@your_twitter_handle',

  twitterUrl: 'https://twitter.com/your_twitter_handle',
    
  discordUrl: 'https://discord.gg/your_discord_invite_code',

  openseaCollectionUrl:
    process.env.NODE_ENV === 'production'
      ? 'https://opensea.io/collection/your_opensea_collection_name'
      : 'https://testnets.opensea.io/collection/your_opensea_collection_name',

  contractAddress:
    process.env.NODE_ENV === 'production'
      ? 'your_mainnet_contract_address'
      : '0xa84e0604864F86c289894F5304d9669A2726C87E',

  scanUrl:
    process.env.NODE_ENV === 'production'
      ? 'https://rinkeby.etherscan.io/address/0xa84e0604864F86c289894F5304d9669A2726C87E'
      : 'https://rinkeby.etherscan.io/address/0xa84e0604864F86c289894F5304d9669A2726C87E',
  // 'https://etherscan.io/address/your_ethereum_contract_address'
  // 'https://rinkeby.etherscan.io/address/0xa84e0604864F86c289894F5304d9669A2726C87E'
};

export default projectConfig;
