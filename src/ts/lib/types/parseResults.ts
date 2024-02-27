type shellIDListObject = {
    shell_item_data: {
        Root: {
            guid: string,
            sort_index: string
        }
    }
}

type shellLinkHeader = {
    atime: string,
    ctime: string,
    // Not really sure what goes here either, so it remains any for now.
    file_attr: Array<any>
    file_size: number,
    // Shows up as null in all the JSON i've seen, but it probably is used for *something*
    hot_key: any,
    mtime: string,
}

type parseResults = {
    command_line_arguments: string,
    extra_data: {
        // No idea what is in here because I've never seen them used.
        extra_data_blocks: Array<any>,
    },
    icon_location: string,
    link_info: {
       local_base_path: string
       volume_id: {
        drive_type: string,
        serial_number: string,
       }
    }
    link_target_id_list: {
        id_list: Array<shellIDListObject>,
    }
    shell_link_header: shellLinkHeader,
    target_full_path: string,
    working_dir: string
}