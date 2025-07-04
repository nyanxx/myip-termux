use if_addrs::get_if_addrs;

fn main() {

    //let target = "rmnet_data0";
    let target = "swlan0";
    let mut found = false;

    if let Ok(addrs) = get_if_addrs() {
        for iface in addrs {
            if iface.name == target {
                if let std::net::IpAddr::V4(ipv4) = iface.ip() {
                    println!("{}", ipv4);
                    found = true;
                    break;
                }
            }
        }
    }

    if !found {
        println!("null");
    }
}
