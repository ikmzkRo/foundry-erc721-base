// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "openzeppelin/utils/Context.sol";
import "openzeppelin/token/ERC721/extensions/ERC721Enumerable.sol";

contract NFT is Context, ERC721Enumerable {
    using Strings for uint256;
    string baseURI = "";

    // デプロイ時にERC-721コントラクトの初期化を実行
    constructor(
        string memory name, // 変数修飾子:memory = 一時領域に保存、途中で変更可能
        string memory symbol,
        string memory uri
    ) ERC721(name, symbol) {
        require(bytes(uri).length > 0, "URI must be non-empty");
        baseURI = uri;
    }

    function mintTo(address to) public virtual {
        // _mint(address to, uint256 tokenId): lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol
        _mint(to, totalSupply()); // 合計供給量 = トークンID
    }

    // override: オーバーライドは、親クラスや親コントラクトで定義された関数を子クラスや子コントラクトで再定義することで、
    // 再定義は、親コントラクトの関数と同じ名前と引数リストを持つことが必要です。
    // override キーワードを使用することで、コンパイラに対して「これは親クラス/コントラクトの関数をオーバーライドする意図です」と伝えます。
    // コンパイラは、間違ってオーバーライドされていないかを確認し、関数のシグネチャが正しいことを確認します。
    // 特に挙動変えないのであれば、overrideしなくてもpublicな関数だったら、実装されます！
    // 今回は関数呼び出し時の規制を緩める目的で上書きを実行しています

    //    /**
    //     * @dev See {IERC721Metadata-tokenURI}.
    //     */
    // function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
    //     _requireMinted(tokenId);

    //     string memory baseURI = _baseURI();
    //     return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString())) : "";
    // }

    // view: データの変更なし、データ参照なし
    // virtual:  データの変更あり、データ参照あり、override可

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        // もし _baseURI が https://example.com/tokens/ で、tokenId が 123 の場合、この関数は次のURIを返します：https://example.com/tokens/123.json。
        return string(abi.encodePacked(baseURI, tokenId.toString(), ".json"));
    }
}
