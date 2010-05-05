package com.lookbackon.ds
{
	import de.polygonal.ds.HashTable;
	/**
	 * These old hashes defined my requirements:</p>
	 * The keys are unaligned variable-length byte arrays.</p>
	 * Sometimes keys are several such arrays.</p>
	 * Sometimes a set of independent hash functions were required.</p>
	 * Average key lengths ranged from 8 bytes to 200 bytes.</p>
	 * Keys might be character strings, numbers, bit-arrays, or weirder things.</p>
	 * Table sizes could be anything, including powers of 2.</p>
	 * The hash must be faster than the old one.</p>
	 * The hash must do a good job. </p>
	 * 
	 * <b>A Survey of Hash Functions:</b></p>
	 * <b>Additive Hash,</b></p>
	 * <b>Rotating Hash,</b></p>
	 * <b>One-at-a-Time Hash,</b></p>
	 * <b>Bernstein's hash,</b></p>
	 * <b>FNV Hash,</b></p>
	 * <b>Goulburn Hash,</b></p>
	 * <b>MurmurHash,</b></p>
	 * <b>Cessu,</b></p>
	 * <b>Pearson's Hash,</b></p>
	 * <b>CRC Hashing,</b></p>
	 * <b>Generalized CRC Hashing,</b></p>
	 * <b>Universal Hashing,</b></p>
	 * <b>Zobrist Hashing,</b></p>
	 * <b>Paul Hsieh's hash...</b></p>
	 * 
	 * @see http://www.burtleburtle.net/bob/hash/doobs.html
	 * @inheritDoc
	 * @author Knight.zhou
	 * 
	 */	
	public class ZobristHashTable extends HashTable
	{
		public function ZobristHashTable(size:int,zobristKey:int)
		{
			//TODO: implement function
			super(size, 
				  function():int{
									return HashTable.hashInt(zobristKey);
							    }
				 );
		}
		/**
		 * @inheritDoc
		 */
		override public function dump():String
		{
			var s:String = "ZobristHashTable:\n";
			for (var i:int = 0; i < _size; i++)
			{
				if (_table[i])
					s += "[" + i + "]" + "\n" + _table[i];
			}
			return s;
		}
	}
}