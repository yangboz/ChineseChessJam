package com.lookbackon.ds
{
	import de.polygonal.ds.HashTable;
	/**
	 * These old hashes defined my requirements:
	 * The keys are unaligned variable-length byte arrays.
	 * Sometimes keys are several such arrays.
	 * Sometimes a set of independent hash functions were required.
	 * Average key lengths ranged from 8 bytes to 200 bytes.
	 * Keys might be character strings, numbers, bit-arrays, or weirder things.
	 * Table sizes could be anything, including powers of 2.
	 * The hash must be faster than the old one.
	 * The hash must do a good job. 
	 * 
	 * A Survey of Hash Functions:
	 * Additive Hash,
	 * Rotating Hash,
	 * One-at-a-Time Hash,
	 * Bernstein's hash,
	 * FNV Hash,
	 * Goulburn Hash,
	 * MurmurHash,
	 * Cessu,
	 * Pearson's Hash,
	 * CRC Hashing,
	 * Generalized CRC Hashing,
	 * Universal Hashing,
	 * Zobrist Hashing,
	 * Paul Hsieh's hash...
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