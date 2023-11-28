// type DataFlagObject = {
//     hasFlag: boolean,
//     flagName: string,
//     flagValue: string
// }

// class LnkParser {
//     private dataView: DataView;
//     private dataFlags: number;

//     constructor(arrayBuffer: ArrayBuffer) {
//         this.dataView = new DataView(arrayBuffer);
//         this.dataFlags = this.parseHeader().dataFlags;
//     }

//     // Read a little-endian 16-bit integer from the DataView
//     private readUInt16LE(offset: number): number {
//         return this.dataView.getUint16(offset, true);
//     }

//     // Read a little-endian 32-bit integer from the DataView
//     private readUInt32LE(offset: number): number {
//         return this.dataView.getUint32(offset, true);
//     }

//     // Read a 64-bit integer (FILETIME) from the DataView
//     private readInt64LE(offset: number): bigint {
//         const lowPart = this.readUInt32LE(offset);
//         const highPart = this.readUInt32LE(offset + 4);
//         return (BigInt(highPart) << BigInt(32)) | BigInt(lowPart);
//     }

//     // Read a UTF-16LE string from the DataView
//     private readString(offset: number, length: number): string {
//         let result = '';
//         for (let i = 0; i < length; i += 2) {
//             const charCode = this.readUInt16LE(offset + i);
//             result += String.fromCharCode(charCode);
//         }
//         return result;
//     }

//     public parseHeader(): any {
//         const headerSize = this.readUInt32LE(0);
//         const linkClassIdentifier = this.readString(4, 16);
//         const dataFlags = this.readUInt32LE(20);
//         const fileAttributeFlags = this.readUInt32LE(24);
//         const creationTime = Number(this.readInt64LE(28));
//         const lastAccessTime = Number(this.readInt64LE(36));
//         const lastModificationTime = Number(this.readInt64LE(44));
//         const fileSize = this.readUInt32LE(52);
//         const iconIndex = this.readUInt32LE(56);
//         const showWindow = this.readUInt32LE(60);
//         const hotKey = this.readUInt16LE(64);

//         return {
//             headerSize,
//             linkClassIdentifier,
//             dataFlags,
//             fileAttributeFlags,
//             creationTime,
//             lastAccessTime,
//             lastModificationTime,
//             fileSize,
//             iconIndex,
//             showWindow,
//             hotKey,
//         };
//     }

//     public getDataFlagName(flag: number): string {
//         switch (flag) {
//             case 0x00000001:
//                 return "HasTargetIDList";
//             case 0x00000002:
//                 return "HasLinkInfo";
//             case 0x00000004:
//                 return "HasName";
//             case 0x00000008:
//                 return "HasRelativePath";
//             case 0x00000010:
//                 return "HasWorkingDir";
//             case 0x00000020:
//                 return "HasArguments";
//             case 0x00000040:
//                 return "HasIconLocation";
//             case 0x00000080:
//                 return "IsUnicode";
//             case 0x00000100:
//                 return "ForceNoLinkInfo";
//             case 0x00000200:
//                 return "HasExpString";
//             case 0x00000400:
//                 return "RunInSeparateProcess";
//             case 0x00000800:
//                 return "Unused1";
//             case 0x00001000:
//                 return "HasDarwinID";
//             case 0x00002000:
//                 return "RunAsUser";
//             case 0x00004000:
//                 return "HasExpIcon";
//             case 0x00008000:
//                 return "NoPidlAlias";
//             case 0x00010000:
//                 return "Unused2";
//             case 0x00020000:
//                 return "RunWithShimLayer";
//             case 0x00040000:
//                 return "ForceNoLinkTrack";
//             case 0x00080000:
//                 return "EnableTargetMetadata";
//             case 0x00100000:
//                 return "DisableLinkPathTracking";
//             case 0x00200000:
//                 return "DisableKnownFolderTracking";
//             case 0x00400000:
//                 return "DisableKnownFolderAlias";
//             case 0x00800000:
//                 return "AllowLinkToLink";
//             case 0x01000000:
//                 return "UnaliasOnSave";
//             case 0x02000000:
//                 return "PreferEnvironmentPath";
//             case 0x04000000:
//                 return "KeepLocalIDListForUNCTarget";
//             default:
//                 return "???";
//         }
//     }

//     private dec2hex(i: number) {
//         return "0x" + i.toString(16).padStart(8, '0');
//     }

//     private getDataFlagInfo(flag: number): DataFlagObject {
//         return {
//             hasFlag: (this.dataFlags & flag) === flag,
//             flagName: this.getDataFlagName(flag),
//             // Convert value to hex
//             flagValue: this.dec2hex(flag)
//         }
//     }

//     public getDataFlags(onlyTrue: boolean = false): any {
//         this.dataFlags = this.readUInt32LE(20); // Assuming the offset for data flags is 20

//         let flags = {
//             hasTargetIDList: this.getDataFlagInfo(0x00000001),
//             hasLinkInfo: this.getDataFlagInfo(0x00000002),
//             hasName: this.getDataFlagInfo(0x00000004),
//             hasRelativePath: this.getDataFlagInfo(0x00000008),
//             hasWorkingDir: this.getDataFlagInfo(0x00000010),
//             hasArguments: this.getDataFlagInfo(0x00000020),
//             hasIconLocation: this.getDataFlagInfo(0x00000040),
//             isUnicode: this.getDataFlagInfo(0x00000080),
//             forceNoLinkInfo: this.getDataFlagInfo(0x00000100),
//             hasExpString: this.getDataFlagInfo(0x00000200),
//             runInSeparateProcess: this.getDataFlagInfo(0x00000400),
//             hasDarwinID: this.getDataFlagInfo(0x00001000),
//             runAsUser: this.getDataFlagInfo(0x00002000),
//             hasExpIcon: this.getDataFlagInfo(0x00004000),
//             noPidlAlias: this.getDataFlagInfo(0x00008000),
//             runWithShimLayer: this.getDataFlagInfo(0x00020000),
//             forceNoLinkTrack: this.getDataFlagInfo(0x00040000),
//             enableTargetMetadata: this.getDataFlagInfo(0x00080000),
//             disableLinkPathTracking: this.getDataFlagInfo(0x00100000),
//             disableKnownFolderTracking: this.getDataFlagInfo(0x00200000),
//             disableKnownFolderAlias: this.getDataFlagInfo(0x00400000),
//             allowLinkToLink: this.getDataFlagInfo(0x00800000),
//             unaliasOnSave: this.getDataFlagInfo(0x01000000),
//             preferEnvironmentPath: this.getDataFlagInfo(0x02000000),
//             keepLocalIDListForUNCTarget: this.getDataFlagInfo(0x04000000),
//         };

//         if (onlyTrue) {
//             // Allows to get only the flags that are true
//             let trueFlags: { [key: string]: boolean } = {};

//             for (let key in flags) {
//                 if (flags.hasOwnProperty(key) && flags[key as keyof typeof flags].hasFlag) {
//                     trueFlags[key] = flags[key as keyof typeof flags].hasFlag;
//                 }
//             }

//             return trueFlags;
//         } else {
//             return flags;
//         }

//         }

//         private readDataString(offset: number, length: number): string {
//             const isUnicode = (this.dataFlags & 0x00000080) !== 0; // Check the Unicode flag
    
//             let result = '';
//             if (isUnicode) {
//                 // Read UTF-16 little-endian string
//                 for (let i = 0; i < length; i += 2) {
//                     const charCode = this.readUInt16LE(offset + i);
//                     result += String.fromCharCode(charCode);
//                 }
//             } else {
//                 // Read ASCII string
//                 for (let i = 0; i < length; i++) {
//                     const charCode = this.dataView.getUint8(offset + i);
//                     result += String.fromCharCode(charCode);
//                 }
//             }
//             return result;
//         }
    
//         public getDataStrings(): any {
//             const fileSize = this.dataView.byteLength;
//             const headerSize = this.readUInt32LE(0);
//             let offset = 76; // Assuming the offset for data strings is 76
        
//             const dataStrings: { [key: string]: string } = {};
        
//             while (offset < fileSize) {
//                 // Read the size of the string
//                 const size = this.readUInt16LE(offset);
        
//                 // Move the offset to the beginning of the string
//                 offset += 2;
        
//                 // Ensure we don't read beyond the bounds of the file
//                 if (offset + size * 2 > fileSize) {
//                     return {
//                         error: `Invalid string size at offset ${offset}`,
//                     };
//                 }
        
//                 // Read the string
//                 const value = this.readString(offset, size);
        
//                 // Determine the type of the string based on the offset
//                 let type;
//                 switch (offset) {
//                     case 76:
//                         type = "description";
//                         break;
//                     case 76 + size * 2:
//                         type = "relativePath";
//                         break;
//                     case 76 + size * 2 * 2:
//                         type = "workingDirectory";
//                         break;
//                     case 76 + size * 2 * 3:
//                         type = "commandLineArguments";
//                         break;
//                     case 76 + size * 2 * 4:
//                         type = "iconLocation";
//                         break;
//                     default:
//                         type = "unknown";
//                 }
        
//                 // Add the string to the result
//                 dataStrings[type] = value;
        
//                 // Move the offset to the next data string
//                 offset += size * 2;
//             }
        
//             return dataStrings;
//         }

//     }

// export default LnkParser